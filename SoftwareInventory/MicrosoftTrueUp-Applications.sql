select DisplayName0 'Application', 
count(Resourceid) 'Count' 

from v_Add_Remove_Programs
where (DisplayName0 like '%Microsoft%Office%Professional%' and InstallDate0 not like 'null') or
(DisplayName0 like '%Microsoft%365%Apps%For%Enterprise%') or
(DisplayName0 like '%Microsoft%Office%365%ProPlus%') or
(DisplayName0 like '%Microsoft%Visio%Standard%' and InstallDate0 not like 'null') or
(DisplayName0 like '%Microsoft%Visio%Professional%'and InstallDate0 not like 'null') or
(DisplayName0 like '%Microsoft%Project%Standard%' and InstallDate0 not like 'null') or
(DisplayName0 like '%Microsoft%Project%Professional%' and InstallDate0 not like 'null') or
(DisplayName0 like '%Nuance%Power%PDF%' and InstallDate0 not like 'null') or
(DisplayName0 like '%Kofax%Power%PDF%' and InstallDate0 not like 'null') or
(DisplayName0 like '%Adobe%Acrobat%Pro%' and InstallDate0 not like 'null') or
(DisplayName0 like '%Adobe%Acrobat%Standard%' and InstallDate0 not like 'null')

group by DisplayName0
order by DisplayName0 asc