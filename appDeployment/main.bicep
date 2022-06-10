targetScope = 'resourceGroup'

param location string = resourceGroup().location
param storageAccountName string
param appInsightName string
param appServicePlanName string
param functionAppName string
param keyVaultName string
param keyVaultSecretName string
param vnetName string
param subnetName string
param keyVaultSecretValue string
param tenantId string
param environment string


module appInsight 'appInsight.bicep' = {
  name:'appInsight'
  params:{
    appInsightName:appInsightName
    env:environment
    location:location
  }
}


module storageAccount 'storageAccount.bicep' = {
  name:'storageAccount'
  params:{
    env:environment
    storageAccountName:storageAccountName
    location:location
  }
}

module appServicePlan 'appServicePlan.bicep' = {
  name:'appServicePlan'
  params:{
    appServicePlanName:appServicePlanName
    env:environment
    location:location
  }
}

module vnet 'vnet.bicep' = {
  name:'vnet'
  params:{
    environment:environment
    vnetName:vnetName
    subnetName:subnetName
    location:location
  }
}

module azureFunctionApp 'azureFunction.bicep' = {
  name:'functionApp'
  params:{
    appInsightInstrumentationKey:appInsight.outputs.appInsightInstrumentationKey
    appPlanId:appServicePlan.outputs.appPlanId
    env:environment
    functionAppName:functionAppName
    storageAccountKey:storageAccount.outputs.stgAccountKey
    location:location
    storageAccountName:storageAccount.outputs.stgAccountName
    subnetId:vnet.outputs.subnetId
  }
  dependsOn:[
    storageAccount
    appServicePlan
  ]
}

module keyVault 'keyVault.bicep' = {
  name:'KeyVault'
  params:{
    env:environment
    keyVaultName:keyVaultName
    secretName:keyVaultSecretName
    tenantId:tenantId
    topSecretValue:keyVaultSecretValue
    location:location
    subnetId:vnet.outputs.subnetId
  }
}
