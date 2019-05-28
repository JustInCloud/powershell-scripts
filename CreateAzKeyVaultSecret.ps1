#Create Resource Group for Azure Key Vault
New-AzResourceGroup -Name "YourKeyVaultGroup" -Location "Australia Southeast"

#Create Vault in Azure Key Vault 
New-AzKeyVault -VaultName "YourKeyVault" -ResourceGroupName "YourKeyVaultGroup" -Location "Australia Southeast"

# Set up 'read' permissions for the specified Azure AD group
Set-AzKeyVaultAccessPolicy -VaultName  -ObjectId (Get-AzADGroup -SearchString 'YourAzureADGroup')[0].Id -PermissionsToSecrets get

#Create Secret in Vault
$secretvalue = ConvertTo-SecureString 'yourpassword' -AsPlaintext -Force
Set-AzKeyVaultSecret -VaultName "YourVault" -Name 'YourSecret' -SecretValue $secretvalue

