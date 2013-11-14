//
//  gcd.h
//  gcd
//
//  Created by Tiny on 11/14/13.
//  Copyright (c) 2013 Tiny. All rights reserved.
//


// @USE:

//        //@ (1)用户队列可以是并发队列，或者是同步队列。
//        test_user_queue();
//        //@ (1)全局队列是并发队列。
//        test_global_queue();
//        //@ (1)dispatch source 是监视某些事件的对象
//        test_dispatch_source();
//        //@ dispatch_suspend() 暂停机制
//        test_dispatch_suspend();





void test_user_queue();
void test_global_queue();
void test_dispatch_source();
void test_dispatch_suspend();
void test_source_read_file(const char *filename);
void test_source_write_file(const char *filename);


/*!
 * @说明
 * 同步队列和异步队列的区别：
 * 当异步队列遇到“特殊”的情况比如 NSLog （将字符输出到控制台这件事）线程会先调用其他的block。而同步则不会。
 */
void test_user_queue()
{
    // 同步的时候打印出有序的结果
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    
    // 异步的结果出来前3句Log后面的结果无法预知。
    //dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"First Block");
        NSLog(@"First Block Incrementing");
        NSLog(@"First Block Incremented");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"Second Block");
        NSLog(@"Second Block Incrementing");
        NSLog(@"Second Block Incremented");
    });
    
    dispatch_async(queue,^{
        NSLog(@"Third Block");
        NSLog(@"Third Block Incrementing");
        NSLog(@"Third Block Incremented");
    });
}

/*!
 * @说明
 * 全局队列是并发队列。
 */
void test_global_queue()
{
    dispatch_queue_t global_queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(global_queue, ^{
        NSLog(@"First Block");
        NSLog(@"First Block Incrementing");
        NSLog(@"First Block Incremented");
    });
    dispatch_async(global_queue, ^{
        NSLog(@"Second Block");
        NSLog(@"Second Block Incrementing");
        NSLog(@"Second Block Incremented");
    });
    dispatch_async(global_queue, ^{
        NSLog(@"Third Block");
        NSLog(@"Third Block Incrementing");
        NSLog(@"Third Block Incremented");
    });
}


/*!
 * @说明
 * source 什么时候会监听到？
 * (1)必须是source所在线程空闲的时候.
 * (2)如果source所在线程是空闲的时候， 是不是只要有事件就会被监听到呢？ 不是的。这要看执行速度。
 */
void test_dispatch_source()
{
    
    // 串行用户队列和主线程的区别：(1)和(2)的区别是主线程有run loop.
    // (1)用户队列：用户队列一直是处于空闲状态，所以得到的是非联结总和的值。
    dispatch_queue_t user_queue = dispatch_queue_create("user_queue", DISPATCH_QUEUE_SERIAL);
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, user_queue);
    // (2)使用主线程：会得到触发器所有值的链接和， 因为主线程一直是非空闲状态。
    //dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_main_queue());
    
    // 设置监听句柄
    dispatch_source_set_event_handler(source, ^{
        size_t estimated = dispatch_source_get_data(source);
        NSLog(@"%ld", estimated);
    });
    
    // 设置取消source的句柄
    dispatch_source_set_cancel_handler(source, ^{
        NSLog(@"cancel handler.");
    });
    dispatch_resume(source);
    
    dispatch_queue_t user_queue_2 = dispatch_queue_create("user_queue_2", DISPATCH_QUEUE_SERIAL);
    dispatch_apply(100000000, user_queue_2, ^(size_t index) {
        //        if (index == 5000) {
        //            // 如果source满足监听条件，有可能得不到完整的联结次数。这里sleep一秒，保证得到完整的联结数。
        //            sleep(1);
        //            dispatch_source_cancel(source);
        //        }
        dispatch_source_merge_data(source, 1);
        
    });
    
}



/*!
 * @说明
 * （1）是暂停队列的一种方式， 但是要在其相关的队列block都执行完毕才能生效。
 * （2）全局队列可能一直有相关联的block在执行， 所以dispatch_suspend() 对于全局队列是“不起作用”的。
 */
void test_dispatch_suspend()
{
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^ {
        NSLog(@"queue1.");
    });
    
    // 局部变量被暂停后会被释放掉。
    dispatch_suspend(queue);
    dispatch_resume(queue);
    
    dispatch_async(queue, ^ {
        NSLog(@"queue2.");
    });
}


void test_source_read_file(const char *filename)
{
    // 为读取文件做准备.
    int fd = open(filename, O_RDONLY);
    if (fd == -1)
        return;
    fcntl(fd, F_SETFL, O_NONBLOCK);  // 避免阻塞read进程
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t readSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_READ, fd, 0, queue);
    if (!readSource)
    {
        close(fd);
        return;
    }
    
    // 设置事件句柄
    dispatch_source_set_event_handler(readSource, ^{
        size_t estimated = dispatch_source_get_data(readSource) + 1;
        // 将数据读到缓冲区.
        char *buffer = (char*)malloc(estimated);
        if (buffer)
        {
            ssize_t actual = read(fd, buffer, (estimated));
            //Boolean done = MyProcessFileData(buffer, actual);  // Process the data.
            Boolean done = YES;
            
            // 释放Buffer.
            free(buffer);
            
            // 如果使用完毕， 取消source
            if (done)
                dispatch_source_cancel(readSource);
        }
    });
    
    dispatch_source_set_cancel_handler(readSource, ^{
        close(fd);
        printf("Successed!");
    });
    
    dispatch_resume(readSource); 

}


void test_source_write_file(const char *filename)
{
    int fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC,
                  (S_IRUSR | S_IWUSR | S_ISUID | S_ISGID));
    if (fd == -1)
        return;
    fcntl(fd, F_SETFL); // Block during the write.
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t writeSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_WRITE, fd, 0, queue);
    if (!writeSource)
    {
        close(fd);
        return;
    }
    
    dispatch_source_set_event_handler(writeSource, ^{
        //size_t bufferSize = 1000;
        //void *buffer = malloc(bufferSize);
        
        size_t actual = 6;
        void *buffer = "wanglei";
        write(fd, buffer, actual);
        
        //free(buffer);
        
        dispatch_source_cancel(writeSource);
    });
    
    dispatch_source_set_cancel_handler(writeSource, ^{
        close(fd);
        printf("Successed!");
    });
    dispatch_resume(writeSource);

}




