//
//  AppDelegate.swift
//  MyBackgroundTask
//
//  Created by 구태호 on 6/7/24.
//

import UIKit
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.example.MyBackgroundTask.refresh", using: nil) { task in
            
            //실제로 수행할 백그라운드 동작 구현
            //나중에 스케쥴 할 때, 해당 태스크의 클래스를 알고 등록을 하게 됩니다. 그래서 다운 캐스팅이 가능해요.
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.example.MyBackgroundTask.userDefaultsCleaning", using: nil) { task in
            
            // Downcast the parameter to a processing task as this identifier is used for a processing request.
            self.handleDatabaseCleaning(task: task as! BGProcessingTask)
        }
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    //실제로 태스크를 수행하는 곳에서는 두 가지를 신경써 주세요.
       // task.expirationHandler 구현
       // 작업의 결과가 어떻게 되었든, task.setTaskCompleted(success: 작업 성공 여부) 호출하기.
       func handleAppRefresh(task: BGAppRefreshTask) {

            //다음 동작을 또 스케쥴 합니다. 반복 수행 시 필요하겠죠?
            //스케쥴 하는 메소드는 이 코드 블럭 이후에 나옵니다!
            scheduleAppRefresh()
            
            let queue = OperationQueue()
            queue.maxConcurrentOperationCount = 1
            
            let context = PersistentContainer.shared.newBackgroundContext()
            let operations = Operations.getOperationsToFetchLatestEntries(using: context, server: server)
            let lastOperation = operations.last!
            
            
            //때에 따라서는 너무 오래걸린다던가 해서 종료될 때가 있죠. 그 때를 위한 정리 핸들러에요.
            task.expirationHandler = {
            
                //예제에서는 OperationQueue를 사용하니까, 모든 동작을 취소했네요.
                queue.cancelAllOperations()
            }

            //이 부분은 Alamofire의 api ressponse 처리 블록 등이 될 수 있겠죠? 예제에서는 Operation Queue를 사용했네요.
            lastOperation.completionBlock = {
            
            //작업 완료 시, setTaskCompleted를 반드시 호출해주세요. 동기로 호출될 필요는 없어요!
                task.setTaskCompleted(success: !lastOperation.isCancelled)
            }

            queue.addOperations(operations, waitUntilFinished: false)
        }
        


    //BGProcessingTask에서 수행할 것을 구현합니다. 위와 똑같아요!

        func handleDatabaseCleaning(task: BGProcessingTask) {
            let queue = OperationQueue()
            queue.maxConcurrentOperationCount = 1

            let context = PersistentContainer.shared.newBackgroundContext()
            let predicate = NSPredicate(format: "timestamp < %@", NSDate(timeIntervalSinceNow: -24 * 60 * 60))
            let cleanDatabaseOperation = DeleteFeedEntriesOperation(context: context, predicate: predicate)
            
            task.expirationHandler = {
                // After all operations are cancelled, the completion block below is called to set the task to complete.
                queue.cancelAllOperations()
            }

            cleanDatabaseOperation.completionBlock = {
                let success = !cleanDatabaseOperation.isCancelled
                if success {
                    // Update the last clean date to the current time.
                    PersistentContainer.shared.lastCleaned = Date()
                }
                
                task.setTaskCompleted(success: success)
            }
            
            queue.addOperation(cleanDatabaseOperation)
        }
    
    //앱이 백그라운드에 들어갔을 때 호출 됨.
       func applicationDidEnterBackground(_ application: UIApplication)
       {
           scheduleAppRefresh()
           scheduleDatabaseCleaningIfNeeded()
       }
       

       // 실제로 태스크를 스케줄 하는 부분.
       
       //BGAppRefreshTaskRequest를 만들어 봅니다
       func scheduleAppRefresh() {
       
               //1. 원하는 형태의 TaskRequest를 만듭니다. 이 때, 사용되는 identifier는 위의 1, 2과정에서 등록한 info.plist의 identifier여야 해요!
           let request = BGAppRefreshTaskRequest(identifier: "com.example.apple-samplecode.ColorFeed.refresh")
           
           //2. 리퀘스트가 언제 실행되면 좋겠는지 지정합니다. 기존의 setMinimumFetchInterval과 동일하다고 합니다.
           //여전히, 언제 실행될지는 시스템의 마음입니다...
           request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60)
           
           
           //3. 실제로 task를 submit 합니다.
           //이 때 주의사항은, submit은 synchronous한 함수라, launching 때 실행하면 메인 스레드가 블락 될 수 있으니
           //OperationQueue, GCD등을 이용해 다른 스레드에서 호출하는 것을 권장한다고 하네요.
           do {
               try BGTaskScheduler.shared.submit(request)
           } catch {
               print("Could not schedule app refresh: \(error)")
           }
       }
       
       
       //BGProcessingTaskRequest를 사용합니다. 옵션이 있는 걸 제외하면 위와 동일해요.
       func scheduleDatabaseCleaningIfNeeded() {
           let lastCleanDate = PersistentContainer.shared.lastCleaned ?? .distantPast

           let now = Date()
           let oneWeek = TimeInterval(7 * 24 * 60 * 60)

           // Clean the database at most once per week.
           guard now > (lastCleanDate + oneWeek) else { return }
           
           
           //이번엔 무거운 DB 작업이니까, BGProcessingTaskRequest를 스케쥴 해줍니다.
           let request = BGProcessingTaskRequest(identifier: "com.example.apple-samplecode.ColorFeed.db_cleaning")
           
           //네트워크 사용여부, 에너지 소모량 옵션도 있습니다.
           request.requiresNetworkConnectivity = false
           request.requiresExternalPower = true
           
           do {
               try BGTaskScheduler.shared.submit(request)
           } catch {
               print("Could not schedule database cleaning: \(error)")
           }
       }
}

