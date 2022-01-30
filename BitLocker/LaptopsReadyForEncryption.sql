Select Distinct R.ResourceID 'ResourceID', 
R.Name0 'Computer Name', 
R.Full_Domain_Name0 'Domain',
CS.Model0 'Model',
Round(Cast(M.TotalPhysicalMemory0 as float )/1024/1024 , 0) 'RAM (GB)',
P.Name0 'Processor', 
S.operatingSystem0 'OS', 
BIOS.SMBIOSBIOSVersion0 'BIOS Version',
CONVERT(date,BIOS.ReleaseDate0) 'BIOS Date',
CASE
WHEN PAR.Type0 like '%GPT%'
THEN 'GPT'
WHEN PAR.Type0 like 'Installable File System'
THEN 'MBR'
END as 'Boot Partition',
TPM.SpecVersion0 'TPM Version',
CASE
WHEN TPM.IsActivated_InitialValue0=0
THEN 'NO'
WHEN TPM.IsActivated_InitialValue0=1
THEN 'YES'
END as 'TPM Enabled',
CASE
WHEN BL.ProtectionStatus0=0
THEN 'NO'
WHEN BL.ProtectionStatus0=1
THEN 'YES'
END as 'BitLocker Enabled',
U.displayName0 'User Name', 
U.department0 'Department', 
U.title0 'Title', 
U.extensionAttribute20 'Region', 
U.extensionAttribute40 'Location', 
U.streetAddress0 'Street Address', 
U.L0 'City', 
U.ST0 'State', 
U.postalCode0 'Zip', 
U.telephoneNumber0 'Phone', 
U.Mail0 'Email',
CONVERT(date,WS.CreationDate) 'Record Creation Date',
CONVERT(date,WS.LastPolicyRequest) 'Last SCCM Contact',
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
inner join [v_R_User] U on R.User_Name0=U.User_Name0
inner join v_GS_ENCRYPTABLE_VOLUME BL on BL.ResourceID=R.ResourceID
inner join v_GS_TPM TPM on TPM.ResourceID = R.ResourceID
inner join v_GS_PARTITION PAR on PAR.ResourceID=R.ResourceID
inner join v_GS_PC_BIOS BIOS on R.ResourceID=BIOS.ResourceID

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
and PAR.DeviceID0 like 'Disk #0, Partition #0'
and BL.DriveLetter0='C:'
and PAR.Type0 like '%GPT%'
and BL.ProtectionStatus0=0
and TPM.IsActivated_InitialValue0=1

order by CS.Model0