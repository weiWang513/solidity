import Web3 from "web3";
import metaCoinArtifact from "../../build/contracts/MetaCoin.json";
import votingArtifact from "../../build/contracts/Voting.json";
import Words from "../../build/contracts/Words.json";
let candidates = {
  'test1': 'candidate-1',
  'test2': 'candidate-2',
  'test3': 'candidate-3',
}
const App = {
  web3: null,
  account: null,
  meta: null,
  wordMeta: null,

  init: async function () {
    const {web3} = this
    try {
      const networkId = await web3.eth.net.getId()
      const deployedNetwork = votingArtifact.networks[networkId]
      const wordsDeployedNetwork = Words.networks[networkId]
      this.meta = new web3.eth.Contract(
        votingArtifact.abi,
        deployedNetwork.address
      )
      this.wordMeta = new web3.eth.Contract(
        Words.abi,
        wordsDeployedNetwork.address
      )
      const accounts = await web3.eth.getAccounts()
      this.account = accounts[0]
      this.loadCurrentVoting()
      this.loadRandomWords()
    } catch (error) {
      console.error(error, 'err')
    }
  },

  loadRandomWords: async function (number) {
    const {getRandom, getSize}  = this.wordMeta.methods
    const count = await getSize().call()
    const msgEl = document.getElementById('msg1')
    if (count === 0) {
      msgEl.innerHTML = 'no data'
    } else {
      let random_num = Math.random() * count
      const word = await getRandom(parseInt(random_num)).call()
      const msg = `内容：${word[0]}<br/>来源：${word[1]}<br/>时间：${formatTime(word[2])}`
      msgEl.innerHTML = msg
    }
  },

  saveWord: async function () {
    const msg = document.getElementById('wordArea').value
    if (msg.length === 0) {
      return
    }
    let timestamp = Date.now()
    const {save} = this.wordMeta.methods
    await save(msg, parseInt(timestamp/1000)).send({from: this.account})
    this.loadRandomWords()
  },

  loadCurrentVoting: async function () {
    let candidateNames = Object.keys(candidates)
    const {totalVotesFor} = this.meta.methods
    for (let i = 0; i < candidateNames.length; i++) {
      const name = candidateNames[i];
      const v = await totalVotesFor(this.web3.utils.utf8ToHex(name)).call()
      console.log(v, 'loadCurrentVoting')
      $(`#${candidates[name]}`).html(v.toString())
    }
  },

  voteAction: async function () {
    let name = $('#candidate').val()
    const {voteForCandidate} = this.meta.methods
    await voteForCandidate(this.web3.utils.utf8ToHex(name)).send({from: this.account})
    this.loadCurrentVoting()
  }
}
function formatNum(n) {
  n = n.toString()
  return n[1] ? n : `0${n}`
}
function formatTime(timestamp) {
  let date = new Date(Number(timestamp * 1000))
  let year = date.getFullYear()
  let month = date.getMonth() + 1
  let days = date.getDate()
  let hour = date.getHours()
  let mints = date.getMinutes()
  let sec = date.getSeconds()
  let fDate = [year, month, days].map(formatNum)
  console.log(fDate, 'fDate')
  return  `${fDate[0]}年${fDate[1]}月${fDate[2]}日 ${hour}:${mints}:${sec}`
}
//   start: async function() {
//     const { web3 } = this;

//     try {
//       // get contract instance
//       const networkId = await web3.eth.net.getId();
//       const deployedNetwork = metaCoinArtifact.networks[networkId];
//       this.meta = new web3.eth.Contract(
//         metaCoinArtifact.abi,
//         deployedNetwork.address,
//       );

//       // get accounts
//       const accounts = await web3.eth.getAccounts();
//       this.account = accounts[0];

//       this.refreshBalance();
//     } catch (error) {
//       console.error("Could not connect to contract or chain.");
//     }
//   },

//   refreshBalance: async function() {
//     const { getBalance } = this.meta.methods;
//     const balance = await getBalance(this.account).call();

//     const balanceElement = document.getElementsByClassName("balance")[0];
//     balanceElement.innerHTML = balance;
//   },

//   sendCoin: async function() {
//     const amount = parseInt(document.getElementById("amount").value);
//     const receiver = document.getElementById("receiver").value;

//     this.setStatus("Initiating transaction... (please wait)");

//     const { sendCoin } = this.meta.methods;
//     await sendCoin(receiver, amount).send({ from: this.account });

//     this.setStatus("Transaction complete!");
//     this.refreshBalance();
//   },

//   setStatus: function(message) {
//     const status = document.getElementById("status");
//     status.innerHTML = message;
//   },
// };

window.App = App;

window.addEventListener("load", function() {
  if (window.ethereum) {
    // use MetaMask's provider
    App.web3 = new Web3(window.ethereum);
    window.ethereum.enable(); // get permission to access accounts
  } else {
    console.warn(
      "No web3 detected. Falling back to http://127.0.0.1:7545. You should remove this fallback when you deploy live",
    );
    // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
    App.web3 = new Web3(
      new Web3.providers.HttpProvider("http://127.0.0.1:7545"),
    );
  }

  App.init();
});
