// SPDX-License-Identifier: GPL-3.0
 pragma solidity >=0.7.0 <0.9.0;


contract new_nth{

 function nth(uint n,int a,int b,int c) pure public returns(int){
    int[100] memory arr;
    arr[0] = a;
    arr[1] =b;
    arr[2] = c;
    uint i;
    for(i =3;i<n;++i){
        arr[i] = arr[i-1]+arr[i - 2 ]+arr[i - 3];
    }
    return arr[n-1];
 }
}

