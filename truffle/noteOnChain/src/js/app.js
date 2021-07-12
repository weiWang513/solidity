App = {
  web3Provider: null,
  contracts: {},

  init: async function() {
    // Load pets.
    // $.getJSON('../pets.json', function(data) {
    //   var petsRow = $('#petsRow');
    //   var petTemplate = $('#petTemplate');

    //   for (i = 0; i < data.length; i ++) {
    //     petTemplate.find('.panel-title').text(data[i].name);
    //     petTemplate.find('img').attr('src', data[i].picture);
    //     petTemplate.find('.pet-breed').text(data[i].breed);
    //     petTemplate.find('.pet-age').text(data[i].age);
    //     petTemplate.find('.pet-location').text(data[i].location);
    //     petTemplate.find('.btn-adopt').attr('data-id', data[i].id);

    //     petsRow.append(petTemplate.html());
    //   }
    // });

    return await App.initWeb3();
  },

  initWeb3: async function() {
    // Modern dapp browsers...
    if (window.ethereum) {
      App.web3Provider = window.ethereum;
      try {
        // Request account access
        await window.ethereum.enable();
      } catch (error) {
        // User denied account access...
        console.error("User denied account access")
      }
    }
    // Legacy dapp browsers...
    else if (window.web3) {
      App.web3Provider = window.web3.currentProvider;
    }
    // If no injected web3 instance is detected, fall back to Ganache
    else {
      App.web3Provider = new Web3.providers.HttpProvider('https://ropsten.infura.io/v3/3fc53bea793b42aaa42dedf68d19f046');
    }
    web3 = new Web3(App.web3Provider);

    return App.initContract();
  },

  initContract: function() {
    /*
     * Replace me...
     */
    $.getJSON('NoteContracts.json', function (data) {
      App.contracts.noteContract = TruffleContract(data)
      App.contracts.noteContract.setProvider(App.web3Provider)
      App.contracts.noteContract.deployed().then(function (instance) {
        App.noteInstance = instance
        console.log(App, 'sender')
        return App.getNotes()
      })
    })

    return App.bindEvents();
  },

  getNotes: function () {
    App.noteInstance.getNoteLen(App.web3Provider.selectedAddress).then(res=>{
      App.noteLength = res
      if (res > 0) {
        App.loadNote(res-1)
      }
    }).catch(err=>{
    })
  },

  loadNote: function (index) {
    App.noteInstance.notes(App.web3Provider.selectedAddress, index).then(function(note) {
      $("#notes").append(
      '<div > <textarea >'
      + note
      + '</textarea></div>' )
      if (index -1 >= 0) {
        App.loadNote(index - 1);
      }
      } ).catch(function(err) {
    });
  },

  bindEvents: function() {
    $("#add_new").on('click', function() {
      $("#loader").show();

      web3.eth.getAccounts(function(error, accounts) {
        if (error) {
          console.log(error);
        }
  
        var account = accounts[0];
        let noteInstance;
        App.contracts.noteContract.deployed().then(function(instance) {
          noteInstance = instance;
  
          // 发送交易领养宠物
          return noteInstance.addNote($("#new_note").val(), {from: account});
        }).then(function(result) {
          // return App.markAdopted();
        }).catch(function(err) {
          console.log(err.message);
        });
      });

      // App.noteInstance.addNote(App.web3Provider.selectedAddress, $("#new_note").val()).then(function(result) {
      //    return App.watchChange();
      // }).catch(function (err) {
      //   console.log(err.message);
      // });
    });
  },

  markAdopted: function() {
    /*
     * Replace me...
     */
  },

  handleAdopt: function(event) {
    event.preventDefault();

    var petId = parseInt($(event.target).data('id'));

    /*
     * Replace me...
     */
  }

};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
