SELECT rs.Netbios_Name0 AS 'PC Name', 
arp.Publisher0 AS 'Publisher', 
arp.DisplayName0 AS 'Software Title', 
arp.Version0 AS 'Version', 
Convert (date, arp.InstallDate0) AS 'Install Date',
DATEDIFF(Day, CONVERT(date,arp.InstallDate0), GETDATE()) AS 'days since installed',
CONVERT(varchar(10), CONVERT(date, arp.InstallDate0), 101) as 'DATE',
CASE WHEN cpt.UserName0 is Null THEN 'N/A' ELSE cpt.UserName0 END AS 'Last Logon Name',
MAX (Convert(smalldatetime,rua.[LastUsedTime0]))as [Time Last Used(GMT)]
    FROM v_Add_Remove_Programs arp 
Join v_R_System rs ON rs.ResourceID = arp.ResourceID 
Join v_GS_COMPUTER_SYSTEM cpt ON cpt.ResourceID = arp.ResourceID 
Join v_GS_CCM_RECENTLY_USED_APPS rua on rua.ResourceID = arp.ResourceID
WHERE arp.DisplayName0 like 'Adobe Acrobat Reader DC' 
and arp.Publisher0 like 'Adobe Systems %'
and arp.Version0 not like '2021.001.20145'
Group by rs.Netbios_Name0, arp.Publisher0, arp.DisplayName0, arp.Version0, arp.InstallDate0, cpt.UserName0
ORDER BY [Time Last Used(GMT)] ASC