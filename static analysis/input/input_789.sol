App = {
  web3Provider: null,
  accounts: [],
  contracts: {},

  init: async function() {
    $.getJSON('../pets.json', function(data) {
      var petsRow = $('#petsRow');
      var petTemplate = $('#petTemplate');

      for (i = 0; i < data.length; i ++) {
        petTemplate.find('.panel-title').text(data[i].name);
        petTemplate.find('img').attr('src', data[i].picture);
        petTemplate.find('.pet-breed').text(data[i].breed);
        petTemplate.find('.pet-age').text(data[i].age);
        petTemplate.find('.pet-location').text(data[i].location);
        petTemplate.find('.btn-adopt').attr('data-id', data[i].id);
        petTemplate.find('.btn-return').attr('data-id', data[i].id);

        petsRow.append(petTemplate.html());
      }
    });

    return await App.initWeb3();
  },

  initWeb3: async function() {

    if (window.ethereum){
      try {
        App.accounts = await window.ethereum.request({ method: "eth_requestAccounts" });
      } catch (error) {
        console.error("User denied account access");
      }
      
      console.log("Account[0]: "+App.accounts[0]);
      
      App.web3Provider = window.ethereum;
      console.log("modern dapp browser");
    }
    else if (window.web3) {
      App.web3Provider = window.web3.currentProvider;
      App.accounts = window.eth.accounts;
      console.log("legacy dapp browser");
    }
    else {
      App.web3Provider = new Web3.providers.HttpProvider('http:
    }
    

    return App.initContract();
    
  },

  initContract: function() {

    $.getJSON('Adoption.json', function(data) {
      var AdoptionArtifact = data;
      try { App.contracts.Adoption = TruffleContract(AdoptionArtifact); } catch (error) { console.error(error); }

      try {
        App.contracts.Adoption.setProvider(App.web3Provider);
      } catch (error){
        console.log(error);
      }
      return App.markAdopted();
    });

    return App.bindEvents();
  },

  bindEvents: function() {
    $(document).on('click', '.btn-adopt', App.handleAdopt);
    $(document).on('click', '.btn-return', App.handleReturn);
  },

  markAdopted: function() {

    var adoptionInstance;
    App.contracts.Adoption.deployed().then(function(instance) {
      adoptionInstance = instance;

      return adoptionInstance.getAdopters.call();
    }).then(function(adopters) {
        
        for(i=0;i<adopters.length;i++){
            if (adopters[i] != '0x0000000000000000000000000000000000000000') {
                if (adopters[i] == App.accounts[0]){
                    $('.panel-pet').eq(i).find('.btn-return').text('Return').attr('disabled', false);
                    $('.panel-pet').eq(i).find('.btn-adopt').text('Adopted').attr('disabled', true);
                } else {
                    $('.panel-pet').eq(i).find('.btn-return').text('-').attr('disabled', true);
                    $('.panel-pet').eq(i).find('.btn-adopt').text('Adopted').attr('disabled', true);
                }
            } else {
                $('.panel-pet').eq(i).find('.btn-return').text('-').attr('disabled', true);
            }
        }

        
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  handleReturn: function(event) {
    event.preventDefault();
    
    var petId = parseInt($(event.target).data('id'));
    
    console.log("handleReturn petId: "+petId+" Account[0]: "+App.accounts[0]);
    console.log("petID:"+petId);
    console.log("Account[0]: "+App.accounts[0]);
    
    var adoptionInstance;
    App.contracts.Adoption.deployed().then(function(instance) {
      adoptionInstance = instance;

      return adoptionInstance.returnPet(petId, {from: App.accounts[0]});
    }).then(function(result){
        App.markAdopted();
    });
    
  },


  handleAdopt: function(event) {
    event.preventDefault();

    var petId = parseInt($(event.target).data('id'));
    console.log("handleAdopt petId: "+petId+" Account[0]: "+App.accounts[0]);
    console.log("petId:"+petId);

    var adoptionInstance;
    App.contracts.Adoption.deployed().then(function(instance) {
      adoptionInstance = instance;

      return adoptionInstance.adopt(petId, {from: App.accounts[0]});
    }).then(function(result){
        App.markAdopted();
    });
    
  }

};

$(function() {
  $(window).load(function() {
    App.init();
  });
});

pragma solidity ^0.5.0;

contract Adoption {
    address[16] public adopters;

    function adopt(uint petId) public returns (uint) {
        require(petId >= 0 && petId <= 15);

        adopters[petId] = msg.sender;

        return petId;
    }

    function getAdopters() public view returns (address[16] memory) {
        return adopters;
    }
    
    function returnPet(uint petId) public returns (uint) {
        require(petId >= 0 && petId <= 15);
        
        require(msg.sender == adopters[petId]);
        
        adopters[petId] = address(0);
        
        return petId;
    }

}


