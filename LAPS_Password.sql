Select Distinct R.ResourceID 'ResourceID', 
R.Name0 'Computer Name',
R.ms_Mcs_AdmPwd0 'LAPS Password',
CAST((convert(bigint, R.ms_Mcs_AdmPwdExpirationTi0) / 864000000000.0 - 109207) AS DATETIME) as 'LAPS PW Expiration'

From 
v_R_System S
inner join v_R_SYSTEM R on S.ResourceID=R.ResourceID

order by R.ms_Mcs_AdmPwd0 desc