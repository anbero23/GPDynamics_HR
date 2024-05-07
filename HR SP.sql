----SP for calculating salaries based on attendance, vacations, extra hours...
                                                         
/*                        
exec SP_TDTARE 2020, 3 , 1, 'R', 'P', 'A',
'','','','','','','','','','','OFISIS','OFISIS'  ,'2020-02-21','2020-03-20'  

exec OFIPLAN.dbo.asistencia 2021,2
*/                        
/*-----------------------------------------------------*/                    
@INNU_ANNO TD_IN_001,                    
@INNU_PERI TD_IN_001
                      
as   
      
set nocount on
declare              
@VNNU_DIAS int          ,                  
@ISCO_WHE1 varchar(255),                    
@ISCO_WHE2 varchar(255),                    
@ISCO_WHE3 varchar(255),                    
@ISCO_WHE4 varchar(255),                    
@ISCO_WHE5 varchar(255),                    
@ISCO_WHE6 varchar(255),                    
@ISCO_WHE7 varchar(255),                    
@ISCO_WHE8 varchar(255),                    
@ISCO_WHE9 varchar(255),                    
@ISCO_WH10 varchar(255) ,                    
@INNU_CORR_PERI TD_IN_001,                    
@ISTI_RPTE varchar(1),                    
@ISST_REPR varchar(1),                    
@ISTI_ORDE varchar(1),                
@ISCO_GRUP TD_VC_008,                    
@ISCO_USUA TD_VC_008, --PARA LA SEGURIDAD  ,
@fe_inic datetime,
@fe_fina datetime                   


              
			  select @fe_inic=max(fe_inic_tare),@fe_fina=max(fe_fina_tare) from TTCNTR_PLAN where co_empr='01' and CO_UNID='001' and nu_anno=@INNU_ANNO and co_plan='emp' and nu_peri=@INNU_PERI
	
			  SELECT @INNU_CORR_PERI=1,@ISTI_RPTE='R',@ISST_REPR='P',@ISTI_ORDE='A',@ISCO_GRUP='OFISIS',@ISCO_USUA='OFISIS',
			  @ISCO_WHE1='',@ISCO_WHE2='',@ISCO_WHE3='',@ISCO_WHE4='',@ISCO_WHE5='',@ISCO_WHE6='',@ISCO_WHE7='',@ISCO_WHE8='',@ISCO_WHE9='',@ISCO_WH10=''

SET FMTONLY OFF --MOD_018
Create Table #TWTARE_RESU_Q09_2              
(CO_EMPR VARCHAR(2) NULL,               
 DE_NOMB_CORT VARCHAR(20) NULL,               
 CO_TRAB VARCHAR(20) NULL,               
 NO_TRAB VARCHAR(155) NULL,               
 CO_UNID VARCHAR(3) NULL,               
 DE_UNID VARCHAR(50) NULL,               
 CO_PLAN VARCHAR(3) NULL,               
 DE_PLAN VARCHAR(50) NULL, 
 -- ECH 24/06/2014               
 CO_DEPA VARCHAR(10) NULL,               
 DE_DEPA VARCHAR(50) NULL, 
 -----             
 CO_AREA VARCHAR(10) NULL,               
 DE_AREA VARCHAR(50) NULL,               
 CO_SECC VARCHAR(10) NULL,               
 DE_SECC VARCHAR(50) NULL,              
 FE_INIC_TARE DATETIME NULL,              
 FE_FINA_TARE DATETIME NULL,              
 CO_DICC_FORM VARCHAR(3) NULL,
 DE_PUES_TRAB VARCHAR(100) NULL,
 FE_INGR DATETIME NULL,
 FE_CESE DATETIME NULL)                          
       
		SET FMTONLY OFF --MOD_018          
create table #TWTARE_RESU_Q09_1(                          
CO_EMPR  VARCHAR(2),                    
DE_NOMB_CORT VARCHAR(20),                    
CO_TRAB  VARCHAR(20),                    
NO_TRAB  VARCHAR(155),                    
FE_TARE  DATETIME,                    
CO_UNID  VARCHAR(3),                    
DE_UNID  VARCHAR(50),                    
CO_PLAN  VARCHAR(3),                    
DE_PLAN  VARCHAR(50), 
-- ECH 24/06/2014               
 CO_DEPA VARCHAR(10),               
 DE_DEPA VARCHAR(50), 
 -----                                 
CO_AREA  VARCHAR(10),                    
DE_AREA  VARCHAR(50),                    
CO_SECC  VARCHAR(10),                    
DE_SECC  VARCHAR(50),                    
                    
NU_HRAS_JORN NUMERIC(16,4),                    
NU_HRAS_NOCT NUMERIC(16,4),                    
NU_HRAS_EX25 NUMERIC(16,4),                    
NU_HRAS_EX35 NUMERIC(16,4),                    
NU_HRAS_DOBL NUMERIC(16,4),                    
NU_HRAS_TRIP NUMERIC(16,4),                    
NU_HRAS_ACOM NUMERIC(16,4),                    
NU_HRAS_DCTO NUMERIC(16,4),                    
NU_DIAS_FALT NUMERIC(16,4),                    
NU_HRAS_PPAG NUMERIC(16,4),                    
NU_HRAS_PNOP NUMERIC(16,4),                    
                    
NU_REPR_JORN NUMERIC(16,4),                    
NU_REPR_NOCT NUMERIC(16,4),                    
NU_REPR_EX25 NUMERIC(16,4),     
NU_REPR_EX35 NUMERIC(16,4),                    
NU_REPR_DOBL NUMERIC(16,4),                    
NU_REPR_TRIP NUMERIC(16,4),                    
NU_REPR_DCTO NUMERIC(16,4),                    
NU_REPR_FALT NUMERIC(16,4),                    
NU_REPR_PPAG NUMERIC(16,4),                    
NU_REPR_PNOP NUMERIC(16,4),                    
ST_PERI  INT    ,TI_REGI_MARC VARCHAR(4)                 
)                    
    
	SET FMTONLY OFF --MOD_018
Create Table #TDLINC_LSH            
(CO_empr VARCHAR(20),              
CO_TRAB VARCHAR(20),                
 NU_DATO_CALC int)
 
	SET FMTONLY OFF --MOD_018
Create Table #TDLINC_LPA          
(CO_empr VARCHAR(20),              
CO_TRAB VARCHAR(20),               
 NU_DATO_CALC int)

 
	SET FMTONLY OFF --MOD_018
Create Table #TDLINC_DME   
(CO_empr VARCHAR(20),              
CO_TRAB VARCHAR(20),               
 NU_DATO_CALC int)
           SET FMTONLY OFF --MOD_018
Create Table #TDLINC_trabajados   
(CO_empr VARCHAR(20),              
CO_TRAB VARCHAR(20),               
 NU_DATO_CALC int)
		   
		   
	SET FMTONLY OFF --MOD_018
Create Table #TDLINC_VAC  
(CO_empr VARCHAR(20),              
CO_TRAB VARCHAR(20),               
 NU_DATO_CALC int)
              
			  
	SET FMTONLY OFF --MOD_018
Create Table #TDLINC_LCG     
(CO_empr VARCHAR(20),              
CO_TRAB VARCHAR(20),               
 NU_DATO_CALC int)

 
	SET FMTONLY OFF --MOD_018
Create Table #TDLINC_sin
(CO_empr VARCHAR(20),              
CO_TRAB VARCHAR(20),               
 NU_DATO_CALC int)
 
	SET FMTONLY OFF --MOD_018
Create Table #TDLINC_TARDANZA 
(CO_empr VARCHAR(20),              
CO_TRAB VARCHAR(20),               
 NU_DATO_CALC int)

 
	SET FMTONLY OFF --MOD_018
Create Table #TDLINC_NOCTURNO  
(CO_empr VARCHAR(20),              
CO_TRAB VARCHAR(20),               
 NU_DATO_CALC int)

 
	SET FMTONLY OFF --MOD_018
Create Table #TDLINC_PERMISO  
(CO_empr VARCHAR(20),              
CO_TRAB VARCHAR(20),               
 NU_DATO_CALC int)
 SET FMTONLY OFF --MOD_018
CREATE INDEX #TWTARE_RESU_Q09_1_IND1                
   ON #TWTARE_RESU_Q09_1 (CO_EMPR, CO_TRAB)                
                
  SET FMTONLY OFF --MOD_018              
CREATE INDEX #TWTARE_RESU_Q09_1_IND2                
   ON #TWTARE_RESU_Q09_1 (CO_EMPR, NO_TRAB)               
       

                
INSERT INTO #TWTARE_RESU_Q09_2                        
SELECT  TMTRAB_EMPR.CO_EMPR,                     
  TMEMPR.DE_NOMB_CORT,                    
  TMTRAB_EMPR.CO_TRAB,               
        TMTRAB_PERS.NO_APEL_PATE + ' ' + TMTRAB_PERS.NO_APEL_MATE + ' ' + TMTRAB_PERS.NO_TRAB NO_TRAB,                    
  TMTRAB_EMPR.CO_UNID,                    
  T10.DE_UNID,                    
  TMTRAB_EMPR.CO_PLAN,                    
  T11.DE_PLAN, 
  TMTRAB_EMPR.CO_DEPA,                    
  T14.DE_DEPA,                     
  TMTRAB_EMPR.CO_AREA,                    
  T12.DE_AREA,                    
  TMTRAB_EMPR.CO_SECC,                    
  T13.DE_SECC,                
   @fe_inic FE_INIC_TARE,               
     @fe_fina FE_FINA_TARE,          
  TREMPR_PLAN.CO_DICC_FORM,TTPUES_TRAB.DE_PUES_TRAB,TMTRAB_EMPR.FE_INGR_EMPR,TMTRAB_EMPR.FE_CESE_TRAB               
FROM  TMTRAB_EMPR LEFT OUTER JOIN TDCCOS_TRAB ON                    
TMTRAB_EMPR.CO_EMPR = TDCCOS_TRAB.CO_EMPR                    
AND TMTRAB_EMPR.CO_TRAB = TDCCOS_TRAB.CO_TRAB                    
AND TDCCOS_TRAB.ST_REPO = 'S',            TMTRAB_PERS, TREMPR_PLAN, TMEMPR, TMUNID_EMPR T10, TTPLAN T11 , TTAREA T12, TTSECC T13 , TTDEPA T14 ,TTPUES_TRAB                  
WHERE TMTRAB_EMPR.CO_EMPR = TMEMPR.CO_EMPR                          
AND TMTRAB_EMPR.CO_EMPR = T10.CO_EMPR                    
AND TMTRAB_EMPR.CO_UNID = T10.CO_UNID                   
AND TMTRAB_EMPR.CO_PLAN = T11.CO_PLAN                     
AND TMTRAB_EMPR.CO_EMPR = T14.CO_EMPR                    
AND TMTRAB_EMPR.CO_DEPA = T14.CO_DEPA                     
AND TMTRAB_EMPR.CO_EMPR = T12.CO_EMPR                    
AND TMTRAB_EMPR.CO_DEPA = T12.CO_DEPA                   
AND TMTRAB_EMPR.CO_AREA = T12.CO_AREA                    
AND TMTRAB_EMPR.CO_EMPR = T13.CO_EMPR                    
AND TMTRAB_EMPR.CO_DEPA = T13.CO_DEPA                   
AND TMTRAB_EMPR.CO_AREA = T13.CO_AREA                    
AND TMTRAB_EMPR.CO_SECC = T13.CO_SECC               
AND TTPUES_TRAB.CO_EMPR=TMTRAB_EMPR.CO_EMPR
AND TTPUES_TRAB.CO_PUES_TRAB=TMTRAB_EMPR.CO_PUES_TRAB           
AND  OFIASIS.dbo.FU_VALI_SEGU_Q01(TMTRAB_EMPR.CO_EMPR, TMTRAB_EMPR.CO_TRAB, @ISCO_USUA, 'T')  = 1                   
AND TMTRAB_PERS.CO_TRAB = TMTRAB_EMPR.CO_TRAB          
AND	(  (TMTRAB_EMPR.FE_CESE_TRAB IS NOT NULL  AND  ( TMTRAB_EMPR.FE_CESE_TRAB >=  @fe_inic /* MOD_006 AND FE_CESE_TRAB <=   '''+ @fe_fina+'''*/ ))
		OR
	   (TMTRAB_EMPR.FE_CESE_TRAB IS NULL)
	)
AND	TMTRAB_EMPR.FE_INGR_EMPR <=   @fe_fina 
            
AND EXISTS( SELECT  T0.CO_EMPR FROM  TRINFO_GRPL T0                    
  WHERE T0.CO_EMPR = TMTRAB_EMPR.CO_EMPR                    
  AND T0.TI_INF1 = TMTRAB_EMPR.CO_UNID                    
  AND T0.TI_INF2 = TMTRAB_EMPR.CO_PLAN                    
  AND T0.CO_GRUP =@ISCO_GRUP)                      
AND TMTRAB_EMPR.CO_EMPR = TREMPR_PLAN.CO_EMPR                    
AND TMTRAB_EMPR.CO_UNID = TREMPR_PLAN.CO_UNID                    
AND TMTRAB_EMPR.CO_PLAN = TREMPR_PLAN.CO_PLAN              
                
				 
				 
Insert Into #TWTARE_RESU_Q09_1(                          
CO_EMPR, DE_NOMB_CORT, CO_TRAB, NO_TRAB, FE_TARE, CO_UNID, DE_UNID, CO_PLAN, DE_PLAN, 
CO_DEPA, DE_DEPA, -- 24/06/2014 
CO_AREA, DE_AREA,                    
CO_SECC, DE_SECC, NU_HRAS_JORN, NU_HRAS_NOCT, NU_HRAS_EX25, NU_HRAS_EX35, NU_HRAS_DOBL, NU_HRAS_TRIP,                    
NU_HRAS_ACOM, NU_HRAS_DCTO, NU_DIAS_FALT, NU_HRAS_PPAG, NU_HRAS_PNOP, NU_REPR_JORN, NU_REPR_NOCT,                    
NU_REPR_EX25, NU_REPR_EX35, NU_REPR_DOBL, NU_REPR_TRIP, NU_REPR_DCTO, NU_REPR_FALT, NU_REPR_PPAG,                    
NU_REPR_PNOP, ST_PERI,TI_REGI_MARC )                    
Select               
t3.CO_EMPR,              
Max(t3.DE_NOMB_CORT),              
t3.CO_TRAB,              
Max(t3.NO_TRAB),              
TDTARE_RESU.FE_TARE,              
Max(t3.CO_UNID),               
Max(t3.DE_UNID),               
Max(t3.CO_PLAN),               
Max(t3.DE_PLAN),  
-- 24/06/2014             
Max(t3.CO_DEPA),               
Max(t3.DE_DEPA), 
-----              
Max(t3.CO_AREA),               
Max(t3.DE_AREA),               
Max(t3.CO_SECC),               
Max(t3.DE_SECC),              
isnull(sum(isnull(TDTARE_RESU.NU_HRAS_PAGA,0)* patindex('TJO', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', TDTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(TDTARE_RESU.NU_HRAS_ORIG,0)* patindex('TJO', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) NU_HRAS_JORN,  
                    
 isnull(sum(isnull(TDTARE_RESU.NU_HRAS_PAGA,0)* patindex('TNO', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', TDTARE_RESU.ST_APRO)),0) +           
 isnull(sum(isnull(TDTARE_RESU.NU_HRAS_ORIG,0)* patindex('TNO', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) NU_HRAS_NOCT,                    
                    
 isnull(sum(isnull(TDTARE_RESU.NU_HRAS_PAGA,0)* patindex('T25', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
patindex('S', TDTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(TDTARE_RESU.NU_HRAS_ORIG,0)* patindex('T25', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) NU_HRAS_EX25,                    
              
 isnull(sum(isnull(TDTARE_RESU.NU_HRAS_PAGA,0)* patindex('T35', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
     patindex('S', TDTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(TDTARE_RESU.NU_HRAS_ORIG,0)* patindex('T35', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) NU_HRAS_EX35,                    
                    
 isnull(sum(isnull(TDTARE_RESU.NU_HRAS_PAGA,0)* patindex('TDO', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', TDTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(TDTARE_RESU.NU_HRAS_ORIG,0)* patindex('TDO', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) NU_HRAS_DOBL,                    
                    
 isnull(sum(isnull(TDTARE_RESU.NU_HRAS_PAGA,0)* patindex('TTR', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', TDTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(TDTARE_RESU.NU_HRAS_ORIG,0)* patindex('TTR', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) NU_HRAS_TRIP,                    
                    
 isnull(sum(isnull(TDTARE_RESU.NU_HRAS_COMP,0)* patindex('S', TRDIST_HRAS.ST_COMP)*                    
       patindex('S', TDTARE_RESU.ST_APRO)),0)  NU_HRAS_COMP,                    
                    
 /*isnull(sum(isnull(TDTARE_RESU.NU_HRAS_PAGA,0)* patindex('THD', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', TDTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(TDTARE_RESU.NU_HRAS_ORIG,0)* patindex('THD', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) NU_HRAS_DCTO,*/           
isnull(sum(isnull(TDTARE_RESU.NU_HRAS_PAGA,0)* patindex('TTA', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', TDTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(TDTARE_RESU.NU_HRAS_ORIG,0)* patindex('TTA', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) +        
isnull(sum(isnull(TDTARE_RESU.NU_HRAS_PAGA,0)* patindex('TAN', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', TDTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(TDTARE_RESU.NU_HRAS_ORIG,0)* patindex('TAN', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) +        
isnull(sum(isnull(TDTARE_RESU.NU_HRAS_PAGA,0)* patindex('THD', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', TDTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(TDTARE_RESU.NU_HRAS_ORIG,0)* patindex('THD', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) NU_HRAS_DCTO,        
                  
 isnull(sum(isnull(TDTARE_RESU.NU_HRAS_PAGA,0)* patindex('TDD', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', TDTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(TDTARE_RESU.NU_HRAS_ORIG,0)* patindex('TDD', TTPARA_HRAS.TI_AFEC_HRAS)*                    
      patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) NU_DIAS_FALT,                    
                          
 isnull(sum(isnull(TDTARE_RESU.NU_HRAS_PAGA,0)* patindex('TPP', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', TDTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(TDTARE_RESU.NU_HRAS_ORIG,0)* patindex('TPP', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) NU_HRAS_PPAG,                 
              
 isnull(sum(isnull(TDTARE_RESU.NU_HRAS_PAGA,0)* patindex('TNP', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', TDTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(TDTARE_RESU.NU_HRAS_ORIG,0)* patindex('TNP', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) NU_HRAS_NPAG,                  
                   
 sum(isnull(TDTARE_RESU.NU_HRAS_REPR,0)* patindex('TJO', TTPARA_HRAS.TI_AFEC_HRAS)) NU_REPR_JORN,                    
 sum(isnull(TDTARE_RESU.NU_HRAS_REPR,0)* patindex('TNO', TTPARA_HRAS.TI_AFEC_HRAS)) NU_REPR_NOCT,                    
 sum(isnull(TDTARE_RESU.NU_HRAS_REPR,0)* patindex('T25', TTPARA_HRAS.TI_AFEC_HRAS)) NU_REPR_EX25,                    
 sum(isnull(TDTARE_RESU.NU_HRAS_REPR,0)* patindex('T35', TTPARA_HRAS.TI_AFEC_HRAS)) NU_REPR_EX35,                    
 sum(isnull(TDTARE_RESU.NU_HRAS_REPR,0)* patindex('TDO', TTPARA_HRAS.TI_AFEC_HRAS)) NU_REPR_DOBL,                    
 sum(isnull(TDTARE_RESU.NU_HRAS_REPR,0)* patindex('TTR', TTPARA_HRAS.TI_AFEC_HRAS)) NU_REPR_TRIP,                    
 sum(isnull(TDTARE_RESU.NU_HRAS_REPR,0)* patindex('TTA', TTPARA_HRAS.TI_AFEC_HRAS))+        
sum(isnull(TDTARE_RESU.NU_HRAS_REPR,0)* patindex('TAN', TTPARA_HRAS.TI_AFEC_HRAS))+        
sum(isnull(TDTARE_RESU.NU_HRAS_REPR,0)* patindex('THD', TTPARA_HRAS.TI_AFEC_HRAS)) NU_REPR_DCTO,                    
 sum(isnull(TDTARE_RESU.NU_HRAS_REPR,0)* patindex('TDD', TTPARA_HRAS.TI_AFEC_HRAS)) NU_REPR_FALT,                    
 sum(isnull(TDTARE_RESU.NU_HRAS_REPR,0)* patindex('TPP', TTPARA_HRAS.TI_AFEC_HRAS)) NU_REPR_PPAG,                    
 sum(isnull(TDTARE_RESU.NU_HRAS_REPR,0)* patindex('TNP', TTPARA_HRAS.TI_AFEC_HRAS)) NU_REPR_NPAG,                    
 CASE WHEN (TDTARE_RESU.FE_TARE >= MIN(t3.FE_INIC_TARE) AND  TDTARE_RESU.FE_TARE <= MAX(t3.FE_FINA_TARE)) THEN 1 ELSE 0 END ST_PERI     ,MAX(TI_REGI_MARC  )               
              
FROM TDTARE_RESU  LEFT OUTER JOIN TCREGI_TRAB ON                
 TDTARE_RESU.CO_TRAB = TCREGI_TRAB.CO_TRAB                  
 AND TDTARE_RESU.CO_EMPR = TCREGI_TRAB.CO_EMPR                  
 AND TDTARE_RESU.FE_TARE = TCREGI_TRAB.FE_REGI,                
  TTPARA_HRAS,               
  TRDIST_HRAS,               
  (SELECT T1.CO_EMPR, T1.CO_DICC_FORM,                     
   isnull(sum(patindex('TJO', T1.TI_AFEC_HRAS) *  patindex('S', T2.ST_REQU_VALI)),0) ST_RVAL_JORN,                    
   isnull(sum(patindex('TNO', T1.TI_AFEC_HRAS) *  patindex('S', T2.ST_REQU_VALI)),0) ST_RVAL_NOCT,                    
   isnull(sum(patindex('T25', T1.TI_AFEC_HRAS) *  patindex('S', T2.ST_REQU_VALI)),0) ST_RVAL_EX25,   
   isnull(sum(patindex('T35', T1.TI_AFEC_HRAS) *  patindex('S', T2.ST_REQU_VALI)),0) ST_RVAL_EX35,                    
   isnull(sum(patindex('TDO', T1.TI_AFEC_HRAS) *  patindex('S', T2.ST_REQU_VALI)),0) ST_RVAL_DOBL,                    
   isnull(sum(patindex('TTR', T1.TI_AFEC_HRAS) *  patindex('S', T2.ST_REQU_VALI)),0) ST_RVAL_TRIP,                    
   1 ST_RVAL_ACOM,                    
   1 ST_RVAL_DCTO,           
   isnull(sum(patindex('TDD', T1.TI_AFEC_HRAS) *  patindex('S', T2.ST_REQU_VALI)),0) ST_RVAL_FALT,                    
   isnull(sum(patindex('TPP', T1.TI_AFEC_HRAS) *  patindex('S', T2.ST_REQU_VALI)),0) ST_RVAL_PPAG, 
   isnull(sum(patindex('TNP', T1.TI_AFEC_HRAS) *  patindex('S', T2.ST_REQU_VALI)),0) ST_RVAL_PNOP                    
   FROM  TTPARA_HRAS T1, TRDIST_HRAS T2                    
   WHERE T1.CO_EMPR = T2.CO_EMPR                    
   AND T1.CO_TIPO_HRAS = T2.CO_TIPO_HRAS                    
   AND T1.TI_DIAS = T2.TI_DIAS                    
   AND T1.NU_CORR_DIST = T2.NU_CORR_DIST                    
   GROUP BY T1.CO_EMPR, T1.CO_DICC_FORM      
  )T1, TTPARA_CRAS T4, #TWTARE_RESU_Q09_2 t3              
              
WHERE t3.CO_TRAB = TDTARE_RESU.CO_TRAB                    
AND t3.CO_EMPR = TDTARE_RESU.CO_EMPR                    
AND (               
   (@ISST_REPR = 'P' OR @ISST_REPR = 'A') AND               
      (TDTARE_RESU.FE_TARE >= t3.FE_INIC_TARE AND TDTARE_RESU.FE_TARE <= t3.FE_FINA_TARE)                    
     OR      
    (               
   (@ISST_REPR = 'R' OR @ISST_REPR = 'A') AND               
      TDTARE_RESU.FE_APRO_REPR >= t3.FE_INIC_TARE AND TDTARE_RESU.FE_APRO_REPR <= t3.FE_FINA_TARE)                    
    )                 
AND TDTARE_RESU.CO_EMPR = TTPARA_HRAS.CO_EMPR                    
AND TDTARE_RESU.CO_TIPO_HRAS = TTPARA_HRAS.CO_TIPO_HRAS                    
AND TDTARE_RESU.TI_DIAS = TTPARA_HRAS.TI_DIAS                    
AND TDTARE_RESU.NU_CORR_DIST = TTPARA_HRAS.NU_CORR_DIST                    
AND TTPARA_HRAS.CO_EMPR = TRDIST_HRAS.CO_EMPR                    
AND TTPARA_HRAS.CO_TIPO_HRAS = TRDIST_HRAS.CO_TIPO_HRAS                    
AND TTPARA_HRAS.TI_DIAS = TRDIST_HRAS.TI_DIAS                    
AND TTPARA_HRAS.NU_CORR_DIST = TRDIST_HRAS.NU_CORR_DIST                     
AND TTPARA_HRAS.CO_DICC_FORM = t3.CO_DICC_FORM                    
AND T1.CO_EMPR = t3.CO_EMPR                    
AND T1.CO_DICC_FORM =t3.CO_DICC_FORM       
AND T3.CO_EMPR = T4.CO_EMPR                
GROUP BY t3.CO_EMPR, t3.CO_TRAB, TDTARE_RESU.FE_TARE            
UNION            
Select               
t3.CO_EMPR,              
Max(t3.DE_NOMB_CORT),              
t3.CO_TRAB,              
Max(t3.NO_TRAB),              
THTARE_RESU.FE_TARE,              
Max(t3.CO_UNID),               
Max(t3.DE_UNID),               
Max(t3.CO_PLAN),               
Max(t3.DE_PLAN),
-- 24/06/2014               
Max(t3.CO_DEPA),               
Max(t3.DE_DEPA),
---               
Max(t3.CO_AREA),               
Max(t3.DE_AREA),               
Max(t3.CO_SECC),               
Max(t3.DE_SECC),              
              
isnull(sum(isnull(THTARE_RESU.NU_HRAS_PAGA,0)* patindex('TJO', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', THTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(THTARE_RESU.NU_HRAS_ORIG,0)* patindex('TJO', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) NU_HRAS_JORN,                    
                    
 isnull(sum(isnull(THTARE_RESU.NU_HRAS_PAGA,0)* patindex('TNO', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', THTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(THTARE_RESU.NU_HRAS_ORIG,0)* patindex('TNO', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) NU_HRAS_NOCT,            
                    
 isnull(sum(isnull(THTARE_RESU.NU_HRAS_PAGA,0)* patindex('T25', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', THTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(THTARE_RESU.NU_HRAS_ORIG,0)* patindex('T25', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) NU_HRAS_EX25,                    
              
 isnull(sum(isnull(THTARE_RESU.NU_HRAS_PAGA,0)* patindex('T35', TTPARA_HRAS.TI_AFEC_HRAS)*                   
   patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', THTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(THTARE_RESU.NU_HRAS_ORIG,0)* patindex('T35', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) NU_HRAS_EX35,                    
                    
 isnull(sum(isnull(THTARE_RESU.NU_HRAS_PAGA,0)* patindex('TDO', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', THTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(THTARE_RESU.NU_HRAS_ORIG,0)* patindex('TDO', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) NU_HRAS_DOBL,                    
                    
 isnull(sum(isnull(THTARE_RESU.NU_HRAS_PAGA,0)* patindex('TTR', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', THTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(THTARE_RESU.NU_HRAS_ORIG,0)* patindex('TTR', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) NU_HRAS_TRIP,                    
                    
 isnull(sum(isnull(THTARE_RESU.NU_HRAS_COMP,0)* patindex('S', TRDIST_HRAS.ST_COMP)*                    
       patindex('S', THTARE_RESU.ST_APRO)),0)  NU_HRAS_COMP,                    
                    
 /*isnull(sum(isnull(THTARE_RESU.NU_HRAS_PAGA,0)* patindex('THD', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', THTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(THTARE_RESU.NU_HRAS_ORIG,0)* patindex('THD', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) NU_HRAS_DCTO,           */        
isnull(sum(isnull(THTARE_RESU.NU_HRAS_PAGA,0)* patindex('TTA', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', THTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(THTARE_RESU.NU_HRAS_ORIG,0)* patindex('TTA', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) +   isnull(sum(isnull(THTARE_RESU.NU_HRAS_PAGA,0)* patindex('TAN', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', THTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(THTARE_RESU.NU_HRAS_ORIG,0)* patindex('TAN', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) +        
isnull(sum(isnull(THTARE_RESU.NU_HRAS_PAGA,0)* patindex('THD', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', THTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(THTARE_RESU.NU_HRAS_ORIG,0)* patindex('THD', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) NU_HRAS_DCTO,         
                    
 isnull(sum(isnull(THTARE_RESU.NU_HRAS_PAGA,0)* patindex('TDD', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', THTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(THTARE_RESU.NU_HRAS_ORIG,0)* patindex('TDD', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) NU_DIAS_FALT,               
                          
 isnull(sum(isnull(THTARE_RESU.NU_HRAS_PAGA,0)* patindex('TPP', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', THTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(THTARE_RESU.NU_HRAS_ORIG,0)* patindex('TPP', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) NU_HRAS_PPAG,                 
              
 isnull(sum(isnull(THTARE_RESU.NU_HRAS_PAGA,0)* patindex('TNP', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('S', TRDIST_HRAS.ST_REQU_VALI)*                    
       patindex('S', THTARE_RESU.ST_APRO)),0) +                    
 isnull(sum(isnull(THTARE_RESU.NU_HRAS_ORIG,0)* patindex('TNP', TTPARA_HRAS.TI_AFEC_HRAS)*                    
       patindex('N', TRDIST_HRAS.ST_REQU_VALI)),0) NU_HRAS_NPAG,                    
                   
 sum(isnull(THTARE_RESU.NU_HRAS_REPR,0)* patindex('TJO', TTPARA_HRAS.TI_AFEC_HRAS)) NU_REPR_JORN,                    
 sum(isnull(THTARE_RESU.NU_HRAS_REPR,0)* patindex('TNO', TTPARA_HRAS.TI_AFEC_HRAS)) NU_REPR_NOCT,                    
 sum(isnull(THTARE_RESU.NU_HRAS_REPR,0)* patindex('T25', TTPARA_HRAS.TI_AFEC_HRAS)) NU_REPR_EX25,                    
 sum(isnull(THTARE_RESU.NU_HRAS_REPR,0)* patindex('T35', TTPARA_HRAS.TI_AFEC_HRAS)) NU_REPR_EX35,                    
 sum(isnull(THTARE_RESU.NU_HRAS_REPR,0)* patindex('TDO', TTPARA_HRAS.TI_AFEC_HRAS)) NU_REPR_DOBL,                    
 sum(isnull(THTARE_RESU.NU_HRAS_REPR,0)* patindex('TTR', TTPARA_HRAS.TI_AFEC_HRAS)) NU_REPR_TRIP,                    
 sum(isnull(THTARE_RESU.NU_HRAS_REPR,0)* patindex('TTA', TTPARA_HRAS.TI_AFEC_HRAS))+        
sum(isnull(THTARE_RESU.NU_HRAS_REPR,0)* patindex('TAN', TTPARA_HRAS.TI_AFEC_HRAS))+        
sum(isnull(THTARE_RESU.NU_HRAS_REPR,0)* patindex('THD', TTPARA_HRAS.TI_AFEC_HRAS)) NU_REPR_DCTO,                    
 sum(isnull(THTARE_RESU.NU_HRAS_REPR,0)* patindex('TDD', TTPARA_HRAS.TI_AFEC_HRAS)) NU_REPR_FALT,                    
 sum(isnull(THTARE_RESU.NU_HRAS_REPR,0)* patindex('TPP', TTPARA_HRAS.TI_AFEC_HRAS)) NU_REPR_PPAG,                    
 sum(isnull(THTARE_RESU.NU_HRAS_REPR,0)* patindex('TNP', TTPARA_HRAS.TI_AFEC_HRAS)) NU_REPR_NPAG,                    
 CASE WHEN (THTARE_RESU.FE_TARE >= MIN(t3.FE_INIC_TARE) AND  THTARE_RESU.FE_TARE <= MAX(t3.FE_FINA_TARE)) THEN 1 ELSE 0 END ST_PERI       ,MAX(TI_REGI_MARC  )           
              
FROM THTARE_RESU  LEFT OUTER JOIN THREGC_TRAB ON                
 THTARE_RESU.CO_TRAB = THREGC_TRAB.CO_TRAB 
 AND THTARE_RESU.CO_EMPR = THREGC_TRAB.CO_EMPR                  
 AND THTARE_RESU.FE_TARE = THREGC_TRAB.FE_REGI,                
  TTPARA_HRAS,               
  TRDIST_HRAS,               
  (SELECT T1.CO_EMPR, T1.CO_DICC_FORM,                     
   isnull(sum(patindex('TJO', T1.TI_AFEC_HRAS) *  patindex('S', T2.ST_REQU_VALI)),0) ST_RVAL_JORN,                    
   isnull(sum(patindex('TNO', T1.TI_AFEC_HRAS) *  patindex('S', T2.ST_REQU_VALI)),0) ST_RVAL_NOCT,                    
   isnull(sum(patindex('T25', T1.TI_AFEC_HRAS) *  patindex('S', T2.ST_REQU_VALI)),0) ST_RVAL_EX25,                    
   isnull(sum(patindex('T35', T1.TI_AFEC_HRAS) *  patindex('S', T2.ST_REQU_VALI)),0) ST_RVAL_EX35,                    
   isnull(sum(patindex('TDO', T1.TI_AFEC_HRAS) *  patindex('S', T2.ST_REQU_VALI)),0) ST_RVAL_DOBL,                    
   isnull(sum(patindex('TTR', T1.TI_AFEC_HRAS) *  patindex('S', T2.ST_REQU_VALI)),0) ST_RVAL_TRIP,                    
   1     ST_RVAL_ACOM,                    
   --isnull(sum(patindex('THD', T1.TI_AFEC_HRAS) *  patindex('S', T2.ST_REQU_VALI)),0) ST_RVAL_DCTO,        
   1     ST_RVAL_DCTO,                     
   isnull(sum(patindex('TDD', T1.TI_AFEC_HRAS) *  patindex('S', T2.ST_REQU_VALI)),0) ST_RVAL_FALT,                    
   isnull(sum(patindex('TPP', T1.TI_AFEC_HRAS) *  patindex('S', T2.ST_REQU_VALI)),0) ST_RVAL_PPAG,                    
   isnull(sum(patindex('TNP', T1.TI_AFEC_HRAS) *  patindex('S', T2.ST_REQU_VALI)),0) ST_RVAL_PNOP                    
   FROM  TTPARA_HRAS T1, TRDIST_HRAS T2                    
   WHERE T1.CO_EMPR = T2.CO_EMPR                    
   AND T1.CO_TIPO_HRAS = T2.CO_TIPO_HRAS                    
   AND T1.TI_DIAS = T2.TI_DIAS                    
   AND T1.NU_CORR_DIST = T2.NU_CORR_DIST                    
      GROUP BY T1.CO_EMPR, T1.CO_DICC_FORM                
  )T1, TTPARA_CRAS T4, #TWTARE_RESU_Q09_2 t3              
              
WHERE t3.CO_TRAB = THTARE_RESU.CO_TRAB                    
AND t3.CO_EMPR = THTARE_RESU.CO_EMPR                    
AND (               
   (@ISST_REPR = 'P' OR @ISST_REPR = 'A') AND               
      (THTARE_RESU.FE_TARE >= t3.FE_INIC_TARE AND THTARE_RESU.FE_TARE <= t3.FE_FINA_TARE)                    
     OR                  
    (               
   (@ISST_REPR = 'R' OR @ISST_REPR = 'A') AND               
      THTARE_RESU.FE_APRO_REPR >= t3.FE_INIC_TARE AND THTARE_RESU.FE_APRO_REPR <= t3.FE_FINA_TARE)                    
    )                    
AND THTARE_RESU.CO_EMPR = TTPARA_HRAS.CO_EMPR                    
AND THTARE_RESU.CO_TIPO_HRAS = TTPARA_HRAS.CO_TIPO_HRAS                    
AND THTARE_RESU.TI_DIAS = TTPARA_HRAS.TI_DIAS                    
AND THTARE_RESU.NU_CORR_DIST = TTPARA_HRAS.NU_CORR_DIST                    
AND TTPARA_HRAS.CO_EMPR = TRDIST_HRAS.CO_EMPR                    
AND TTPARA_HRAS.CO_TIPO_HRAS = TRDIST_HRAS.CO_TIPO_HRAS                    
AND TTPARA_HRAS.TI_DIAS = TRDIST_HRAS.TI_DIAS                    
AND TTPARA_HRAS.NU_CORR_DIST = TRDIST_HRAS.NU_CORR_DIST                     
AND TTPARA_HRAS.CO_DICC_FORM = t3.CO_DICC_FORM                    
AND T1.CO_EMPR = t3.CO_EMPR                    
AND T1.CO_DICC_FORM =t3.CO_DICC_FORM       
AND T3.CO_EMPR = T4.CO_EMPR                
GROUP BY t3.CO_EMPR, t3.CO_TRAB, THTARE_RESU.FE_TARE             
                       
 -- REPORTE RESUMIDO                     
                 
				
            
 
 INSERT INTO #TDLINC_VAC
 SELECT CO_EMPR,CO_TRAB, COUNT(*) FROM TCREGI_tRAB
 WHERE FE_regi>=@fe_inic AND FE_regi<=@fe_fina
 AND TI_REGI_MARC='VAC'
 GROUP BY CO_EMPR, CO_TRAB
 UNION 
 SELECT CO_EMPR,CO_TRAB, COUNT(*) FROM THREGC_TRAB
 WHERE FE_regi>=@fe_inic AND FE_regi<=@fe_fina
 AND TI_REGI_MARC='VAC'
 GROUP BY CO_EMPR, CO_TRAB

 
 INSERT INTO #TDLINC_DME
 SELECT CO_EMPR, CO_TRAB, COUNT(*) FROM TCREGI_tRAB
 WHERE FE_regi>=@fe_inic AND FE_regi<=@fe_fina
 AND TI_DIAS='1'
 GROUP BY CO_EMPR, CO_TRAB
 UNION 
 SELECT  CO_EMPR,CO_TRAB, COUNT(*) FROM THREGC_TRAB
 WHERE FE_regi>=@fe_inic AND FE_regi<=@fe_fina
 AND TI_DIAS='1' --'DME'

 GROUP BY CO_EMPR, CO_TRAB


 INSERT INTO #TDLINC_LPA
 SELECT CO_EMPR,CO_TRAB, COUNT(*) FROM TCREGI_tRAB
 WHERE FE_regi>=@fe_inic AND FE_regi<=@fe_fina
 AND TI_DIAS='8'
 GROUP BY CO_EMPR, CO_TRAB
 UNION 
 SELECT CO_EMPR,CO_TRAB, COUNT(*) FROM THREGC_TRAB
 WHERE FE_regi>=@fe_inic AND FE_regi<=@fe_fina
 AND TI_DIAS='8'
 GROUP BY CO_EMPR, CO_TRAB


 INSERT INTO #TDLINC_LSH
 SELECT CO_EMPR,CO_TRAB, COUNT(*) FROM TCREGI_tRAB
 WHERE FE_regi>=@fe_inic AND FE_regi<=@fe_fina
 AND TI_DIAS='3'--LSH'
 GROUP BY CO_EMPR, CO_TRAB
 UNION 
 SELECT CO_EMPR,CO_TRAB, COUNT(*) FROM THREGC_TRAB
 WHERE FE_regi>=@fe_inic AND FE_regi<=@fe_fina
 AND TI_DIAS='3'
 GROUP BY CO_EMPR, CO_TRAB




 INSERT INTO #TDLINC_LCG
 SELECT CO_EMPR,CO_TRAB, COUNT(*) FROM TCREGI_tRAB
 WHERE FE_regi>=@fe_inic AND FE_regi<=@fe_fina
 AND TI_DIAS='4' --'LCG'
 GROUP BY CO_EMPR, CO_TRAB
 UNION 
 SELECT CO_EMPR,CO_TRAB, COUNT(*) FROM THREGC_TRAB
 WHERE FE_regi>=@fe_inic AND FE_regi<=@fe_fina
 AND TI_DIAS='4' --'LCG'
 GROUP BY CO_EMPR, CO_TRAB

 
 INSERT INTO #TDLINC_sin
 SELECT CO_EMPR,CO_TRAB, COUNT(*) FROM TCREGI_tRAB
 WHERE FE_regi>=@fe_inic AND FE_regi<=@fe_fina
 AND TI_REGI_MARC='LSI'
 GROUP BY CO_EMPR, CO_TRAB
 UNION 
 SELECT CO_EMPR,CO_TRAB, COUNT(*) FROM THREGC_TRAB
 WHERE FE_regi>=@fe_inic AND FE_regi<=@fe_fina
 AND TI_REGI_MARC='LSI'
 GROUP BY CO_EMPR, CO_TRAB
 
 
 INSERT INTO #TDLINC_TARDANZA
 select CO_EMPR,co_Trab, COUNT(*) from #TWTARE_RESU_Q09_1
 where NU_HRAS_DCTO>0
 GROUP BY CO_EMPR, CO_TRAB
 
                     
 INSERT INTO #TDLINC_NOCTURNO
 select co_empr, co_Trab, COUNT(*) from #TWTARE_RESU_Q09_1
 where NU_HRAS_NOCT>0
 GROUP BY CO_EMPR, CO_TRAB

 
 INSERT INTO #TDLINC_PERMISO
 select CO_emPR,co_Trab, COUNT(*) from #TWTARE_RESU_Q09_1
 where NU_HRAS_PPAG>0
 GROUP BY CO_EMPR, CO_TRAB

      
	  
 INSERT INTO #TDLINC_trabajados
	  SELECT CO_emPR,co_Trab, COUNT(*) FROM TCREGI_tRAB WHERE  FE_regi>=@fe_inic AND FE_regi<=@fe_fina
 AND TI_REGI_MARC='RMC' AND TI_DIAS NOT IN (
 SELECT DE_OBJE_TIPO FROM ofiasis..TTAYUD_ASIS  
         WHERE CO_AYUD = 'LIC'  )
		 GROUP BY  CO_emPR,co_Trab



 SELECT #TWTARE_RESU_Q09_1.CO_EMPR,
 MAX(#TWTARE_RESU_Q09_1.DE_NOMB_CORT) EMPRESA,                                                   
  #TWTARE_RESU_Q09_1.CO_TRAB, 
  MAX(#TWTARE_RESU_Q09_1.NO_TRAB) NOMBRE,  
  MAX(#TWTARE_RESU_Q09_1.DE_AREA) DE_AREA,
  MAX(DE_PUES_TRAB) PUESTO_TRABAJO,
  convert(varchar, MAX(FE_INGR),103) FE_INGRESO,
   convert(varchar, MAX(fe_cese),103)  FE_CESE,               
  ISNull(MAX(#TDLINC_VAC.NU_DATO_CALC),0) 'VACACIONES',  
  ROUND(SUM(NU_DIAS_FALT),2)    DIAS_FALTA,
    ISNull(MAX(#TDLINC_dme.NU_DATO_CALC),0)   DESCANSO_MEDICO,
    ISNull(MAX(#TDLINC_LCG.NU_DATO_CALC),0) LICENCIA_CON_GOCE,
ISNull(MAX(#TDLINC_LSH.NU_DATO_CALC),0)  LICENCIA_SIN_GOCE,
  ISNull(MAX(#TDLINC_SIN.NU_DATO_CALC),0) LICENCIA_SINDICAL,
    ISNull(MAX(#TDLINC_LPA.NU_DATO_CALC),0) LICENCIA_PATERNIDAD,
     ISNull(MAX(#TDLINC_NOCTURNO.NU_DATO_CALC),0) DIAS_NOCTURNOS,              
   ROUND(SUM(NU_HRAS_NOCT) ,2)  NU_HRAS_NOCT,
    ISNull(max(#TDLINC_TARDANZA.NU_DATO_CALC),0) DIAS_TARDANZAS  ,
  ROUND(SUM(NU_HRAS_DCTO),2)  TARDANZAS,  
    ISNull(MAX(#TDLINC_PERMISO.NU_DATO_CALC),0) DIAS_PERMISO,
   ROUND(SUM(NU_HRAS_PPAG),2)  NU_HRAS_PPAG ,
  ROUND(SUM(NU_HRAS_JORN),2)  NU_HRAS_JORN,   
   ISNULL(ROUND(MAX(#TDLINC_trabajados.NU_DATO_CALC),2),2)  DIAS_TRABAJADOS,                
   ROUND(SUM(NU_HRAS_EX25) ,2)  '25',                    
   ROUND( SUM(NU_HRAS_EX35) ,2)  '35',                    
  ROUND( SUM(NU_HRAS_DOBL) ,2)  DOBLE             
 FROM  #TWTARE_RESU_Q09_1   INNER JOIN #TWTARE_RESU_Q09_2
 ON #TWTARE_RESU_Q09_1.CO_EMPR=#TWTARE_RESU_Q09_2.CO_EMPR
 AND #TWTARE_RESU_Q09_1.CO_TRAB=#TWTARE_RESU_Q09_2.CO_TRAB
 LEFT OUTER JOIN #TDLINC_NOCTURNO
 ON #TDLINC_NOCTURNO.CO_empr=#TWTARE_RESU_Q09_1.CO_EMPR
 AND #TDLINC_NOCTURNO.CO_tRAB=#TWTARE_RESU_Q09_1.CO_TRAB
 LEFT OUTER JOIN #TDLINC_TARDANZA
 ON #TDLINC_TARDANZA.CO_empr=#TWTARE_RESU_Q09_1.CO_EMPR
 AND #TDLINC_TARDANZA.CO_tRAB=#TWTARE_RESU_Q09_1.CO_TRAB
 LEFT OUTER JOIN #TDLINC_PERMISO
 ON #TDLINC_PERMISO.CO_empr=#TWTARE_RESU_Q09_1.CO_EMPR
 AND #TDLINC_PERMISO.CO_tRAB=#TWTARE_RESU_Q09_1.CO_TRAB
 LEFT OUTER JOIN #TDLINC_vac
 ON #TDLINC_vac.CO_empr=#TWTARE_RESU_Q09_1.CO_EMPR
 AND #TDLINC_vac.CO_tRAB=#TWTARE_RESU_Q09_1.CO_TRAB
 LEFT OUTER JOIN #TDLINC_dme
 ON #TDLINC_dme.CO_empr=#TWTARE_RESU_Q09_1.CO_EMPR
 AND #TDLINC_dme.CO_tRAB=#TWTARE_RESU_Q09_1.CO_TRAB
 LEFT OUTER JOIN #TDLINC_lsh
 ON #TDLINC_lsh.CO_empr=#TWTARE_RESU_Q09_1.CO_EMPR
 AND #TDLINC_lsh.CO_tRAB=#TWTARE_RESU_Q09_1.CO_TRAB
 LEFT OUTER JOIN #TDLINC_lpa
 ON #TDLINC_lpa.CO_empr=#TWTARE_RESU_Q09_1.CO_EMPR
 AND #TDLINC_lpa.CO_tRAB=#TWTARE_RESU_Q09_1.CO_TRAB
 LEFT OUTER JOIN #TDLINC_LCG
 ON #TDLINC_LCG.CO_empr=#TWTARE_RESU_Q09_1.CO_EMPR
 AND #TDLINC_LCG.CO_tRAB=#TWTARE_RESU_Q09_1.CO_TRAB
 LEFT OUTER JOIN #TDLINC_SIN
 ON #TDLINC_SIN.CO_empr=#TWTARE_RESU_Q09_1.CO_EMPR
 AND #TDLINC_SIN.CO_tRAB=#TWTARE_RESU_Q09_1.CO_TRAB
 LEFT OUTER JOIN #TDLINC_trabajados
 ON #TDLINC_trabajados.CO_empr=#TWTARE_RESU_Q09_1.CO_EMPR
 AND #TDLINC_trabajados.CO_tRAB=#TWTARE_RESU_Q09_1.CO_TRAB

 


 
 GROUP BY #TWTARE_RESU_Q09_1.CO_EMPR, #TWTARE_RESU_Q09_1.CO_TRAB    
 ORDER BY 2, 4, 6, 8, 10, 12       

 -- REPORTE DETALLADO                    
                  
/*--------------------------------------FIN --------------------------------*/ 



set nocount off
GO



