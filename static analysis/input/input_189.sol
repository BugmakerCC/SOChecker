contractToken1.methods.function1().send({from: account}).on('transactionHash', (hash)=>{
contractToken2.methods.function2().send({from: account}).on('transactionHash',(hash)=> console.log('this was successful'));
}


