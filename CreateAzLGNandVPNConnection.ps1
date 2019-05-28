#Variables
$resourcegroupname = 's2svpn-rg'
$location = 'australia southeast'
$LNGname = 'myvnetloc1'
$LNGIP = 'x.x.x.x'
$awssubnet = 'x.x.x.x/xx'
$sharedvpnkey = 'insertyourkey'
$vpnconnectname = 'yourvpnconnectionname'
$vpnname = 'yourvpngatewayname'

New-AzLocalNetworkGateway -Name $LNGname -ResourceGroupName $resourcegroupname `
-Location $location -GatewayIpAddress $LNGIP -AddressPrefix $awssubnet

#Variables for VPN Connection
$gateway1= Get-AzVirtualNetworkGateway -Name $vpnname -ResourceGroupName $resourcegroupname
$local= Get-AzLocalNetworkGateway -Name $LNGname -ResourceGroupName $resourcegroupname

#Create VPN connection
New-AzVirtualNetworkGatewayConnection -Name $vpnconnectname -ResourceGroupName $resourcegroupname `
-Location $location -VirtualNetworkGateway1 $gateway1 -LocalNetworkGateway2 $local `
-ConnectionType IPsec -RoutingWeight 10 -SharedKey $sharedvpnkey

