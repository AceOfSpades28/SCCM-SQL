select name0 [Device Name],count(*) Total from v_r_system
group by name0
having (count(name0))>1
order by Name0