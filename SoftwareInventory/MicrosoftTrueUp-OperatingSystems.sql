Select S.operatingSystem0 'Operating System',
count(S.ResourceID) 'Count'

From 
v_R_System S

where S.operatingSystem0 like '%Windows%'

group by S.operatingSystem0
order by S.operatingSystem0