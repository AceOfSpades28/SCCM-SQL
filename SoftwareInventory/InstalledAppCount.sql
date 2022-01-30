select DisplayName0 'Application', 
Version0 'Version', 
count(Resourceid) 'Count' 

from v_Add_Remove_Programs
where DisplayName0 like '%Google%Chrome%'

group by DisplayName0, Version0
order by 'Version' desc