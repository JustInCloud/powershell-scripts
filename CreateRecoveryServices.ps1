
#Migration Variables
$resourcegroupname = 'awsmigrationrg'
$storageaccountname = 'awsmigration246733'
$recoveryvaultname = 'myVault'
$vnetname = 'myMigrationVnet' 
$location = 'australia southeast'
$skuname = 'Standard_RAGRS'
$vnetaddress = '192.168.4.0/28'


#New Resource Group
New-AzResourceGroup -Name $resourcegroupname -Location $location

#New Storage Account
New-AzStorageAccount -Name $storageaccountname -ResourceGroupName $resourcegroupname -Location $location  -Type $skuname

#New Recovery Services Vault
New-AzRecoveryServicesVault -Name $recoveryvaultname -ResourceGroupName $resourcegroupname -Location $location

#Set up an Azure Network
New-AzVirtualNetwork -Name $vnetname -ResourceGroupName $resourcegroupname -Location $location -AddressPrefix $vnetaddress

