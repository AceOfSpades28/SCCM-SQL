Select
Pac.PackageID as 'App_ID',
col.CollectionID as 'AppCollection_ID',
Vaa.ApplicationName as 'ApplicationName',
Ds.CollectionName as 'CollectionName',

CASE
when col.CollectionType = 1 Then 'User'
when col.CollectionType = 2 Then 'Device' Else 'Others'
End as 'CollType',

CASE
when Vaa.DesiredConfigType = 1 Then 'Install'
when vaa.DesiredConfigType = 2 Then 'Uninstall’' Else 'Others'
End as 'DeploymentType',

CASE
when Ds.DeploymentIntent = 1 Then 'Required'
when Ds.DeploymentIntent = 2 Then 'Available'
when Ds.DeploymentIntent = 3 Then 'Simulate'
End as 'Purpose',

Ds.DeploymentTime as 'AvailableTime',
Ds.EnforcementDeadline as 'RequiredTime',
Vaa.CreationTime as 'Created On',
Vaa.LastModificationTime as 'LastModifiedOn',
Vaa.LastModifiedBy as 'LastModifiedBy'

from v_DeploymentSummary Ds

inner join v_ApplicationAssignment Vaa on Ds.AssignmentID = Vaa.AssignmentID
left join v_Package Pac on Vaa.ApplicationName = Pac.Name
left join v_collection col on Ds.CollectionName = col.Name

Where Ds.DeploymentIntent = '1'

order by Ds.CollectionName asc