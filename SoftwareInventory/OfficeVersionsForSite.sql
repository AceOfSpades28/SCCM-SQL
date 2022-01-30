Select Distinct R.ResourceID 'ResourceID',
Boundary.DisplayName 'SCCM Boundary',
U.extensionAttribute20 'Region',
U.extensionAttribute40 'Location',
R.Name0 'Computer Name',
CS.Model0 'Model',
--Round(Cast(M.TotalPhysicalMemory0 as float )/1024/1024 , 0) 'RAM',
--P.Name0 'Processor',
U.displayName0 'User Name',
U.title0 'Title',
streetAddress0 'Street Address',
U.L0 'City',
st0 'State',
postalCode0 'Zip',
U.telephoneNumber0 'Phone',
Mail0 'Email',
S.operatingSystem0 'Operating System',
s.operatingSystemVersion0 'OS Version',
arp.DisplayName0 'Software'

From 
v_R_System S
inner join v_R_SYSTEM R on S.ResourceID=R.ResourceID
inner join v_UserMachineRelation UM on R.ResourceID=UM.MachineResourceID
inner join v_GS_SYSTEM_ENCLOSURE ENC on S.ResourceID=ENC.ResourceID
inner join v_GS_COMPUTER_SYSTEM CS on R.ResourceID=CS.ResourceID
inner join v_GS_PROCESSOR P on R.ResourceID=P.ResourceID
inner join v_GS_X86_PC_MEMORY M on R.ResourceID=M.ResourceID
inner join [v_R_User] U on R.User_Name0= U.User_Name0
inner join v_Add_Remove_Programs arp on R.ResourceID = arp.ResourceID
inner join v_RA_System_IPSubnets RA on RA.ResourceID=R.ResourceID
inner join vSMS_Boundary boundary on RA.ip_subnets0 = boundary.Value

where
U.employeeID0 not like '99999999'  and U.User_Account_Control0=512 and UM.RelationActive=1
and arp.DisplayName0 like '%Office Professional%'
and (Boundary.DisplayName like '%Georgetown%' or Boundary.DisplayName like '%Buda%')
order by 'SCCM Boundary', 'User Name'