select
 apps.DisplayName as 'ApplicationName',
 apps.Softwareversion as 'Version',
 pkg.PackageID,
 CASE pkg.PackageType
 WHEN 0 THEN 'Package'
 WHEN 3 THEN 'Driver'
 WHEN 4 THEN 'TaskSequence'
 WHEN 5 THEN 'SoftwareUpdate'
 WHEN 6 THEN 'DeviceSettings'
 WHEN 7 THEN 'Virtual'
 WHEN 8 THEN 'Application'
 WHEN 257 THEN 'Image'
 WHEN 258 THEN 'BootImage'
 WHEN 259 THEN 'OSInstall'
 END AS 'PackageType',
 apps.NumberOfDeploymentTypes,
 apps.NumberOfDeployments,
 apps.NumberOfDependentTs
 from fn_ListLatestApplicationCIs(1033) apps
 left join v_TaskSequencePackageReferences tspr on tspr.ObjectID = apps.ModelName
 left join vSMS_ApplicationAssignment ass on ass.AssignedCI_UniqueID = apps.CI_UniqueID
 left join v_Package pkg on pkg.SecurityKey = apps.ModelName
 where
 PackageType = 8
 and apps.IsLatest=1
 and ass.AssignmentName IS NULL
 and tspr.PackageID IS NULL
 and apps.NumberOfDeployments = 0
 and apps.NumberOfDependentTs = 0
 and apps.IsLatest=1
 order by apps.DisplayName