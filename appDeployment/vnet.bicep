param location string = resourceGroup().location
param vnetName string
param subnetName string
param environment string

resource vnet 'Microsoft.Network/virtualNetworks@2021-08-01' = {
  name:vnetName
  location:location
  tags:{
    environment:environment
  }
  properties:{
    addressSpace:{
      addressPrefixes:[
        '10.0.0.0/16'
      ]
    }
    subnets:[
      {
        name:subnetName
        properties:{
          addressPrefix:'10.0.0.0/24'
          serviceEndpoints:[
            {
              locations:[
                location
              ]
              service:'Microsoft.KeyVault'
            }
          ]
          delegations:[
            {
              name:'subnetDelegation'
              properties:{
                serviceName:'Microsoft.Web/serverFarms'
              }
            }
            
          ]
        }
      }
    ]
  }

  resource subnet 'subnets' existing = {
    name:subnetName
  }
}

output vnetId string = vnet.id
output subnetId string = vnet::subnet.id
