use "C:\Users\patri\Desktop\gitMono\Monografia\desc_stats\analise_reg\base2_familias.dta", clear
cd "C:\Users\patri\Desktop\gitMono\Monografia\desc_stats\analise_reg"

rename idade__60 idade_mais_60

tab i,gen(i_)

gen ncomplier = 0
replace ncomplier = 1 if complier ==0

 logout, save(Tab2_corr) tex replace: ttable2 var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  cod_destino_lixo_domic_fam  ///
		  num_mor num_mulheres pct_mulheres idade_m idade___17 idade___35  idade___60 idade_mais_60 ///		
		  cod_especie_domic_fam pessoas10 idades_ate_17 idades_ate_35 idades_ate_60 idades_mais_60, by(complier)

probit complier var_hansen  dis_cbd  dur_cbd  dis_cral  dur_cral , rob

outreg2 using myreg3.xls, replace ctitle(Model 1) addtext(i*,YES)

probit complier var_hansen  dis_cbd  dur_cbd  dis_cral  dur_cral   	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam, rob 

outreg2 using myreg3.xls, append ctitle(Model 2) addtext(i*,YES)


probit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam i_*, vce(cluster i)
		  
outreg2 using myreg3.xls, append ctitle(Model 3) addtext(i*,YES)


//
xtile x = vlr_renda_media_fam,nq(10)

probit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		    marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam i_* if x <= 2, vce(cluster i)
outreg2 using rich1.xls, replace ctitle(20% poorest)

probit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		    marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam i_* if x <= 5, vce(cluster i)
outreg2 using rich1.xls, append ctitle(50% poorest)		  
probit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		    marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam i_* if x >= 5, vce(cluster i)
outreg2 using rich1.xls, append ctitle(50% richer)
probit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		    marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam i_* if x >= 9, vce(cluster i)
outreg2 using rich1.xls, append ctitle(20% richer)
//

gen age17 = idade___17/(idade___17 + idade___35 + idade___60 + idade_mais_60)
gen age35 = idade___35/(idade___17 + idade___35 + idade___60 + idade_mais_60)
gen age60 = idade___60/(idade___17 + idade___35 + idade___60 + idade_mais_60)
gen agemais60 = idade_mais_60/(idade___17 + idade___35 + idade___60 + idade_mais_60)

sum age17 age35 age60 agemais60


ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m  ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam i_* (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age17 > 0, vce(cluster i)  
outreg2 using ivprobit1.xls, replace ctitle(Model 1)

ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m  ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam i_* (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age35 > 0, vce(cluster i) 
outreg2 using ivprobit1.xls, append ctitle(Model 2)
		  
ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m  ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam i_* (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age60 > 0, vce(cluster i) 
outreg2 using ivprobit1.xls, append ctitle(Model 3)
		  
ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m  ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam i_* (idades_ate_35 idades_ate_60 idades_mais_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if agemais60 > 0, vce(cluster i)
outreg2 using ivprobit1.xls, append ctitle(Model 4)		  



ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m  ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam i_* (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age17 >= idades_ate_17, vce(cluster i)  
outreg2 using ivprobit2.xls, replace ctitle(Model 1)

ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m  ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam i_* (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age35 >= idades_ate_35, vce(cluster i) 
outreg2 using ivprobit2.xls, append ctitle(Model 2)
		  
ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m  ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam i_* (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age60 >= idades_ate_60, vce(cluster i) 
outreg2 using ivprobit2.xls, append ctitle(Model 3)
		  
ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m  ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam i_* (idades_ate_35 idades_ate_60 idades_mais_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if agemais60 >= idades_mais_60, vce(cluster i)
outreg2 using ivprobit2.xls, append ctitle(Model 4)		  






ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m idade___17 idade___35  idade___60 ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam  (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age17 >= .5, vce(cluster i)  
outreg2 using ivprobit3.xls, replace ctitle(Model 1)

ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m idade___17 idade___35  idade___60 ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age35 >= .5, vce(cluster i) 
outreg2 using ivprobit3.xls, append ctitle(Model 2)
		  
ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m idade___17 idade___35  idade___60 ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age60 >= .5, vce(cluster i) 
outreg2 using ivprobit3.xls, append ctitle(Model 3)
		  
ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m idade___17 idade___35  idade___60 ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam (idades_ate_35 idades_ate_60 idades_mais_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if agemais60 >= .5, vce(cluster i)
outreg2 using ivprobit3.xls, append ctitle(Model 4)		  



ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m idade___17 idade___35  idade___60 ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age17 >= idades_ate_17, vce(cluster i)  
outreg2 using ivprobit4.xls, replace ctitle(Model 1)

ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m idade___17 idade___35  idade___60 ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam  (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age35 >= idades_ate_35, vce(cluster i) 
outreg2 using ivprobit4.xls, append ctitle(Model 2)
		  
ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m idade___17 idade___35  idade___60 ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam  (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age60 >= idades_ate_60, vce(cluster i) 
outreg2 using ivprobit4.xls, append ctitle(Model 3)
		  
ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m idade___17 idade___35  idade___60 ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam (idades_ate_35 idades_ate_60 idades_mais_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if agemais60 >= idades_mais_60, vce(cluster i)
outreg2 using ivprobit4.xls, append ctitle(Model 4)






ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m  ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age17 >= idades_ate_17, vce(cluster i)  
outreg2 using ivprobit5.xls, replace ctitle(Model 1)

ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m  ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam  (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age35 >= idades_ate_35, vce(cluster i) 
outreg2 using ivprobit5.xls, append ctitle(Model 2)
		  
ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m  ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam  (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age60 >= idades_ate_60, vce(cluster i) 
outreg2 using ivprobit5.xls, append ctitle(Model 3)
		  
ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m  ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam (idades_ate_35 idades_ate_60 idades_mais_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if agemais60 >= idades_mais_60, vce(cluster i)
outreg2 using ivprobit5.xls, append ctitle(Model 4)	



ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  val_desp_aluguel_fam 	///
		  pct_mulheres idade_m  ///
		  i_* (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age17 >= idades_ate_17, vce(cluster i)  
outreg2 using ivprobit6.xls, replace ctitle(Model 1)

ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  val_desp_aluguel_fam 	///
		  pct_mulheres idade_m  ///
		  i_*   (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age35 >= idades_ate_35, vce(cluster i) 
outreg2 using ivprobit6.xls, append ctitle(Model 2)
		  
ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  val_desp_aluguel_fam 	///
		  pct_mulheres idade_m  ///
		  i_*  (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age60 >= idades_ate_60, vce(cluster i) 
outreg2 using ivprobit6.xls, append ctitle(Model 3)
		  
ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  val_desp_aluguel_fam 	///
		  pct_mulheres idade_m  ///
		  i_*  (idades_ate_35 idades_ate_60 idades_mais_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if agemais60 >= idades_mais_60, vce(cluster i)
outreg2 using ivprobit6.xls, append ctitle(Model 4)

//




ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  val_desp_aluguel_fam 	///
		  pct_mulheres idade_m  ///
		  i_* (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age17 > 0, vce(cluster i)  
outreg2 using ivprobit7.xls, replace ctitle(Model 1)

ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  val_desp_aluguel_fam 	///
		  pct_mulheres idade_m  ///
		  i_*   (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age35 > 0, vce(cluster i) 
outreg2 using ivprobit7.xls, append ctitle(Model 2)
		  
ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  val_desp_aluguel_fam 	///
		  pct_mulheres idade_m  ///
		  i_*  (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age60 > 0, vce(cluster i) 
outreg2 using ivprobit7.xls, append ctitle(Model 3)
		  
ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  val_desp_aluguel_fam 	///
		  pct_mulheres idade_m  ///
		  i_*  (idades_ate_35 idades_ate_60 idades_mais_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if agemais60 > 0, vce(cluster i)
outreg2 using ivprobit7.xls, append ctitle(Model 4)		
		

//
probit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  val_desp_aluguel_fam 	///
		  pct_mulheres idade_m  ///
		  i_* idades_ate_17 idades_ate_35 idades_ate_60 pessoas10   if age17 > 0, vce(cluster i)  
outreg2 using ivprobit8.xls, replace ctitle(Model 1)

probit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  val_desp_aluguel_fam 	///
		  pct_mulheres idade_m  ///
		  i_*  idades_ate_17 idades_ate_35 idades_ate_60 pessoas10   if age35 > 0, vce(cluster i) 
outreg2 using ivprobit8.xls, append ctitle(Model 2)
		  
probit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  val_desp_aluguel_fam 	///
		  pct_mulheres idade_m  ///
		  i_*  idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  if age60 > 0, vce(cluster i) 
outreg2 using ivprobit8.xls, append ctitle(Model 3)
		  
probit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  val_desp_aluguel_fam 	///
		  pct_mulheres idade_m  ///
		  i_*  idades_ate_35 idades_ate_60 idades_mais_60 pessoas10 if agemais60 > 0, vce(cluster i)
outreg2 using ivprobit8.xls, append ctitle(Model 4)	

//
probit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  val_desp_aluguel_fam 	///
		  pct_mulheres idade_m  ///
		  i_* idades_ate_17 idades_ate_35 idades_ate_60 pessoas10   if age17 >= idades_ate_17, vce(cluster i)  
outreg2 using ivprobit9.xls, replace ctitle(Model 1)

probit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  val_desp_aluguel_fam 	///
		  pct_mulheres idade_m  ///
		  i_*  idades_ate_17 idades_ate_35 idades_ate_60 pessoas10   if age35 >= idades_ate_35, vce(cluster i) 
outreg2 using ivprobit9.xls, append ctitle(Model 2)
		  
probit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  val_desp_aluguel_fam 	///
		  pct_mulheres idade_m  ///
		  i_*  idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  if age60 >= idades_ate_60, vce(cluster i) 
outreg2 using ivprobit9.xls, append ctitle(Model 3)
		  
probit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  val_desp_aluguel_fam 	///
		  pct_mulheres idade_m  ///
		  i_*  idades_ate_35 idades_ate_60 idades_mais_60 pessoas10 if agemais60 >= idades_mais_60, vce(cluster i)
outreg2 using ivprobit9.xls, append ctitle(Model 4)	











// sem instrumento
probit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m idade___17 idade___35  idade___60 ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam idades_ate_17 idades_ate_35 idades_ate_60 i_* if idade___17 >= 1, vce(cluster i)

probit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m idade___17 idade___35  idade___60 ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam idades_ate_17 idades_ate_35 idades_ate_60 i_* if idade___35 >= 1, vce(cluster i)
		  
probit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m idade___17 idade___35  idade___60 ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam idades_ate_17 idades_ate_35 idades_ate_60 i_* if idade___60 >= 1, vce(cluster i)
		  
probit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m idade___17 idade___35  idade___60 ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam idades_ate_17 idades_ate_35 idades_ate_60 i_* if idade_mais_60 >= 1, vce(cluster i)
		  

		  // 2
probit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m idade___17 idade___35  idade___60 ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam idades_ate_17 idades_ate_35 idades_ate_60 i_* if idade___17 >= 1, vce(cluster i)

probit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m idade___17 idade___35  idade___60 ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam idades_ate_17 idades_ate_35 idades_ate_60 i_* if idade___35 >= 1, vce(cluster i)
		  
probit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m idade___17 idade___35  idade___60 ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam idades_ate_17 idades_ate_35 idades_ate_60 i_* if idade___60 >= 1, vce(cluster i)
		  
probit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m idade___17 idade___35  idade___60 ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam idades_ate_17 idades_ate_35 idades_ate_60 i_* if idade_mais_60 >= 1, vce(cluster i)
		  

		  

		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m idade___17 idade___35  idade___60 ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam i_*(idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age17 >= 0, vce(cluster i)  
outreg2 using ivprobit4.xls, replace ctitle(Model 1)

ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m idade___17 idade___35  idade___60 ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam i_* (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age35 >= 0, vce(cluster i) 
outreg2 using ivprobit4.xls, append ctitle(Model 2)
		  
ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m idade___17 idade___35  idade___60 ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam i_*(idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age60 >= 0, vce(cluster i) 
outreg2 using ivprobit4.xls, append ctitle(Model 3)
		  
ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m idade___17 idade___35  idade___60 ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam i_*(idades_ate_35 idades_ate_60 idades_mais_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if agemais60 >= 0, vce(cluster i)
outreg2 using ivprobit4.xls, append ctitle(Model 4)






ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m  ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam i_*(idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age17 >= idades_ate_17, vce(cluster i)  
outreg2 using ivprobit5.xls, replace ctitle(Model 1)

ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m  ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam  i_*(idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age35 >= idades_ate_35, vce(cluster i) 
outreg2 using ivprobit5.xls, append ctitle(Model 2)
		  
ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m  ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam i_* (idades_ate_17 idades_ate_35 idades_ate_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if age60 >= idades_ate_60, vce(cluster i) 
outreg2 using ivprobit5.xls, append ctitle(Model 3)
		  
ivprobit complier var_hansen dis_cbd  dur_cbd  dis_cral  dur_cral  	///
		  vlr_renda_media_fam  marc_pbf_fam  qtd_pessoas_domic_fam 	///
		  cod_agua_canalizada_fam qtd_comodos_domic_fam 			///
		  qtd_comodos_dormitorio_fam  val_desp_aluguel_fam 			///
		  cod_banheiro_domic_fam  cod_escoa_sanitario_domic_fam 	///
		  num_mor num_mulheres pct_mulheres idade_m  ///
		  cod_destino_lixo_domic_fam  cod_especie_domic_fam i_*(idades_ate_35 idades_ate_60 idades_mais_60 pessoas10  = pessoas00 idades_ate_17_0 idades_ate_35_0 idades_ate_60_0 idades_mais_60_0) if agemais60 >= idades_mais_60, vce(cluster i)
outreg2 using ivprobit5.xls, append ctitle(Model 4)			  
				  
				  


 cumul idades_ate_17,gen(c1)
 cumul idades_ate_35 
 cumul idades_ate_60 
 cumul idades_mais_60

. reg val_desp_aluguel_fam wi hansen v complier vlr_renda_media_fam

num_mor num_mulheres pct_mulheres idade_m idade___17 idade___35 idade___60 idade__60
