
#VPN Variables
$resourcegroupname = 's2svpn-rg'
$storageaccountname = 's2svpn4'
$vnetname = 'myvnet'
$subname = 'mysubnet'
$gatesubname = 'GatewaySubnet'
$gateipname = 'gwipconfig1'
$publicipname = 'gwpublicip'
$vpnname = 'gwvpn' 
$location = 'australia southeast'
$skuname = 'Standard_LRS'
$vnetaddress = '172.16.0.0/16'
$subaddress = '172.16.0.0/24'
$gatesubaddress = '172.16.254.0/24'


#New Resource Group
New-AzResourceGroup -Name $resourcegroupname -Location $location

#New Storage Account
New-AzStorageAccount -Name $storageaccountname -ResourceGroupName $resourcegroupname -Location $location  -Type $skuname

#New Virtual Network
$virtualNetwork = New-AzVirtualNetwork `
  -ResourceGroupName $resourcegroupname `
  -Location $location `
  -Name $vnetname `
  -AddressPrefix $vnetaddress

#New Subnet
$subnetConfig = Add-AzVirtualNetworkSubnetConfig `
  -Name $subname `
  -AddressPrefix $subaddress `
  -VirtualNetwork $virtualNetwork

#Set subnet to Virtual Network
$virtualNetwork | Set-AzVirtualNetwork

#New Gateway Subnet
$subnetConfig = Add-AzVirtualNetworkSubnetConfig `
  -Name $gatesubname `
  -AddressPrefix $gatesubaddress `
  -VirtualNetwork $virtualNetwork

#Set gateway subnet to Virtual Network
$virtualNetwork | Set-AzVirtualNetwork

#Set variable for Virtual Network
$vnet = Get-AzVirtualNetwork -ResourceGroupName $resourcegroupname -Name $vnetname

#Assign Public IP Address
$gwpip= New-AzPublicIpAddress -Name $publicipname -ResourceGroupName $resourcegroupname -Location $location -AllocationMethod Dynamic

#Create Gateway IP
$vnet = Get-AzVirtualNetwork -Name $vnetname -ResourceGroupName $resourcegroupname
$subnet = Get-AzVirtualNetworkSubnetConfig -Name $gatesubname -VirtualNetwork $vnet
$gwipconfig = New-AzVirtualNetworkGatewayIpConfig -Name $gateipname -SubnetId $subnet.Id -PublicIpAddressId $gwpip.Id

#Create the VPN Gateway
New-AzVirtualNetworkGateway -Name $vpnname -ResourceGroupName $resourcegroupname  `
-Location $location -IpConfigurations $gwipconfig -GatewayType Vpn `
-VpnType RouteBased -GatewaySku VpnGw1


