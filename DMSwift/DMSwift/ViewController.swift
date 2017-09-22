//
//  ViewController.swift
//  DMSwift
//
//  Created by lbq on 2017/9/19.
//  Copyright © 2017年 lbq. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
//    let a :Array<Int> = [1,5,3]
    let a :Array<Int> = [1,5,3,4,6,9,7,8]
    override func viewDidLoad() {
        super.viewDidLoad()
        let b = insertionSortOf(a);//升序
        print(b)
        let c = insertionSortOf(a,byCriteria: >);//降序
        print(c)
        let d = selectionSortOf(a)
        print(d)
        
        let e = shellSortOf(a);
        print(e)
        
        let f = selection2SortOf(a,byCriteria:<);
        print(f)
        
        let g = bubbleSortOf(a);
        print("冒泡排序:\n \(g)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //插入排序
    /*
     基本思想:
     将一个记录插入到已排序好的有序表中，从而得到一个新，记录数增1的有序表。即：先将序列的第1个记录看成是一个有序的子序列，然后从第2个记录逐个进行插入，直至整个序列有序为止。
     */
    typealias Criteria<T> = (T,T) -> Bool
    func insertionSortOf<T: Comparable>(_ coll:Array<T>, byCriteria: Criteria<T> = {$0 < $1}) -> Array<T> {
        guard coll.count > 1 else {
            return coll
        }
        var result = coll
        for i in 1 ..< coll.count {
            var j = i;
            let value = result[j]
            while j > 0 && !byCriteria(result[j-1],value) {
                result.swapAt(j-1, j)
                j -= 1
            }
        }
        return result;
    }
    
    //希尔排序
    //一般简单排序
    func shellInsertionSortOf<T: Comparable>(_ coll: Array<T>, dk: Int,byCriteria: Criteria<T>) -> Array<T> {
        guard coll.count > 1 else {
            return coll
        }
        var result = coll
        for i in dk ..< coll.count {
            var j = i;
            let value = result[j]
            while j >= dk && !byCriteria(result[j-dk],value) {
                result.swapAt(j-dk, j)
                j -= dk
            }
        }
        return result;
    }
    
    func shellSortOf<T: Comparable>(_ coll: Array<T>,byCriteria: Criteria<T> = {$0 < $1}) -> Array<T> {
        var dk = coll.count/2;
        var result:Array<T> = [];
        while(dk >= 1){
           result = shellInsertionSortOf(coll, dk: dk, byCriteria:byCriteria)
            dk = dk/2;
        }
        return result;
    }
    
    
    //简单选择排序
    func selectionSortOf<T:Comparable>(_ coll: Array<T>, byCriteria: Criteria<T> = {$0 < $1}) -> Array<T>{
        guard coll.count > 1 else {
            return coll
        }
        var result = coll
        for i in 0 ..< coll.count-1 {
            var index = i;
            for j in i+1 ..< coll.count {
                if !byCriteria(result[index],result[j]) {
                    index = j
                }
            }
            if index != i {
                result.swapAt(index, i)
            }
        }
        return result;
    }
    //二元选择排序
    func selection2SortOf<T:Comparable>(_ coll: Array<T>, byCriteria: Criteria<T> = {$0 < $1}) -> Array<T>{
        guard coll.count > 1 else {
            return coll
        }
        var result = coll
        for i in 0 ..< coll.count/2 {
            var index1 = i;
            var index2 = i;
            for j in i+1 ..< coll.count-i {
                
                if !byCriteria(result[index1],result[j]) {
                    index1 = j
                }
                
                if byCriteria(result[index2],result[j]) {
                    index2 = j;
                }
            }
            if index1 != i {
                result.swapAt(index1, i)
            }
            
            print("max = \(index2)")
            if index2 != coll.count-i-1 {
                if index2 == i { //找到i对应的元素在交换之后的位置
                    result.swapAt(index1, coll.count-i-1)
                } else {
                    result.swapAt(index2, coll.count-i-1)
                }
            }
        }
        return result;
    }
    
    //冒泡排序
    func bubbleSortOf<T:Comparable>(_ coll: Array<T>, byCriteria: Criteria<T> = {$0 < $1}) -> Array<T>{
        guard coll.count > 1 else {
            return coll
        }
        var result = coll
        for i in 0 ..< coll.count-1 {
            for j in  0 ..< coll.count-i-1 {
                if !byCriteria(result[j],result[j+1]) {
                    result.swapAt(j, j+1)
                }
            }
        }
        return result;
    }
    
}

