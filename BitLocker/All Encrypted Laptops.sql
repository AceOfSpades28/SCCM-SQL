Select Distinct R.ResourceID 'ResourceID', 
R.Name0 'Computer Name', 
r.Full_Domain_Name0 'Domain',
CS.Model0 'Model',
CASE
WHEN BL.ProtectionStatus0=0
THEN 'NO'
WHEN BL.ProtectionStatus0=1
THEN 'YES'
END as 'BitLocker',
Round(Cast(M.TotalPhysicalMemory0 as float )/1024/1024 , 0) 'RAM (GB)',
S.operatingSystem0 'OS', 
U.User_Name0 'User Name', 
U.department0 'Department', 
U.title0 'Title', 
U.telephoneNumber0 'Phone', 
U.Mail0 'Email',
WS.CreationDate'Record Creation Date',
WS.LastPolicyRequest 'Last Policy Request',
DATEDIFF ( DAY , WS.LastPolicyRequest , getdate() ) 'Days Offline'
  
From 
v_R_System S
inner join v_R_SYSTEM R on S.ResourceID=R.ResourceID
inner join v_UserMachineRelation UM on R.ResourceID=UM.MachineResourceID
inner join v_GS_SYSTEM_ENCLOSURE ENC on S.ResourceID=ENC.ResourceID
inner join v_GS_COMPUTER_SYSTEM CS on R.ResourceID=CS.ResourceID
inner join v_GS_PROCESSOR P on R.ResourceID=P.ResourceID
inner join v_GS_X86_PC_MEMORY M on R.ResourceID=M.ResourceID
inner join v_RA_System_IPSubnets RA on RA.ResourceID=R.ResourceID
inner join vWorkstationStatus WS on WS.ResourceID=R.ResourceID
inner join v_CH_ClientSummary CH on CH.ResourceId=R.ResourceId
Left join [v_R_User] U on R.User_Name0=U.User_Name0
left join v_GS_ENCRYPTABLE_VOLUME BL on BL.ResourceID=R.ResourceID

where
(ENC.ChassisTypes0 = '8' OR
ENC.ChassisTypes0 = '9' OR
ENC.ChassisTypes0 = '10' OR
ENC.ChassisTypes0 = '11' OR
ENC.ChassisTypes0 = '12' OR
ENC.ChassisTypes0 = '14' OR
ENC.ChassisTypes0 = '18' OR
ENC.ChassisTypes0 = '21' OR
ENC.ChassisTypes0 = '31')
and BL.DriveLetter0='C:'
and BL.ProtectionStatus0=1

and CH.ClientActiveStatus=1
--and R.Full_Domain_Name0 like '%BUILDWITHBMC%'
order by R.Name0