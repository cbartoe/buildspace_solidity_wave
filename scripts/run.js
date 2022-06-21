
const main = async () => {
    // const [owner, randomPerson] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy({
        value: hre.ethers.utils.parseEther('0.1'),
    });
    await waveContract.deployed();
    console.log("Contract addy:", waveContract.address);

    // console.log("Contract deployed to contract address:", waveContract.address);
    // console.log("Contract deployed by wallet address:", owner.address);

    /* Get contract balance */
    let contractBalance = await hre.ethers.provider.getBalance(
        waveContract.address
    );

    /* Post the contract balance */
    console.log(
        "Contract balance: ",
        hre.ethers.utils.formatEther(contractBalance)
    );

    /* let waveCount;
    waveCount = await waveContract.getTotalWaves();
    console.log(waveCount.toNumber()); */
    
    // Let's try 2 waves now
    const waveTxn = await waveContract.wave("This is wave #1");
    await waveTxn.wait();

    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log("Contract Balance: ",
        hre.ethers.utils.formatEther(contractBalance)
    );

    const waveTxn2 = await waveContract.wave("This is wave #2");
    await waveTxn2.wait();
    
    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log("Contract Balance: ",
        hre.ethers.utils.formatEther(contractBalance)
    );

    /* old wave schema
    // let's send a  wave!
    let waveTxn = await waveContract.wave("A Message!");
    await waveTxn.wait(); // waiting for the wave/message to be mined
    */

    // Let's get the contract balance after the wave
    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log("Contract Balance: ",
        hre.ethers.utils.formatEther(contractBalance)
    );

    /* 
    // Let's send a second wave
    const [_, randomPerson] = await hre.ethers.getSigners();
    waveTxn = await waveContract.connect(randomPerson).wave("Another happy message!");
    await waveTxn.wait(); */ 

    let allWaves = await waveContract.getAllWaves();
    console.log(allWaves);


    // Old commands before message addition
    /*
    let wavesPerAddy = await waveContract.saveWaver();
    await wavesPerAddy.wait();

    waveCount = await waveContract.getTotalWaves();

    waveTxn = await waveContract.connect(randomPerson).wave();
    await waveTxn.wait();

    let wavesPerAddy2 = await waveContract.connect(randomPerson).saveWaver();
    await wavesPerAddy2.wait();

    waveCount = await waveContract.getTotalWaves();

    waveTxn = await waveContract.connect(randomPerson).wave();
    await waveTxn.wait();

    wavesPerAddy2 = await waveContract.connect(randomPerson).saveWaver();
    await wavesPerAddy2.wait();

    waveCount = await waveContract.getTotalWaves();
    */
};

const runMain = async () => {
    try {
        await main();
        process.exit(0); //exit Node process without error
    } catch (error) {
        console.log(error);
        process.exit(1); //exit Node process while indicating 'Uncaught Fatal Exception' error
    }
    // Read more about Node exit ('process.exit(num)') status codes at: https://stackoverflow.com/a/4716
};

runMain();
