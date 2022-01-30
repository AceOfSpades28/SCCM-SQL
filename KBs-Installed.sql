SELECT Distinct R.ResourceID,
R.Name0 'Computer Name',
CS.Manufacturer0 'Manufacturer',
CS.Model0 'Model',
Convert (smalldatetime, R.Last_Logon_Timestamp0) 'Last Logon',
"Windows 10 Version"=
case OS.BuildNumber0
when '19043' then 'Windows 10 21H1'
when '19042' then 'Windows 10 20H2'
when '19041' then 'Windows 10 2004'
when '18363' then 'Windows 10 1909'
when '18362' then 'Windows 10 1903'
when '17763' then 'Windows 10 1809'
when '17134' then 'Windows 10 1803'
when '16299' then 'Windows 10 1709'
when '15063' then 'Windows 10 1703'
when '14393' then 'Windows 10 1607'
when '10586' then 'Windows 10 1511'
when '10240' then 'Windows 10 1507'
end,
R.User_Domain0 'Domain',
U.Full_User_Name0 'User Name',
U.department0 'Department',
U.title0 'Title',
U.Mail0 'Email',
QF.HotFixID0 'KB'
--ARP.Publisher0 'Publisher',
--ARP.DisplayName0 'Software Title',
--ARP.Version0 'Version'

FROM v_R_System R

inner join v_R_User U on R.User_Name0 = U.User_Name0
inner join v_GS_OPERATING_SYSTEM OS on OS.ResourceID = R.ResourceID
inner join v_GS_COMPUTER_SYSTEM CS on CS.ResourceID = R.ResourceID
inner join v_GS_QUICK_FIX_ENGINEERING QF on QF.ResourceID = R.ResourceID
inner join v_Add_Remove_Programs ARP on ARP.ResourceID = R.ResourceID

Where (QF.HotFixID0 = 'KB5006670' or
QF.HotFixID0 = 'KB5005539' or
QF.HotFixID0 = 'KB5005541' or
QF.HotFixID0 = 'KB5006667')
--and (ARP.Publisher0 like '%MiTek%' and
--ARP.DisplayName0 like '%Structure%')

order by R.Name0