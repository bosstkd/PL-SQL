

1)      CREATE TABLE MH_HOTEL ( code_h VARCHAR(200) UNIQUE NOT NULL PRIMARY KEY, raison_social VARCHAR(500), adresse VARCHAR(2000), Commune VARCHAR(80), wilaya VARCHAR(80), code_postal VARCHAR(20), nrc VARCHAR(30) UNIQUE, nif VARCHAR(50), nai VARCHAR(50), rib VARCHAR(100), tel VARCHAR(25), fax VARCHAR(25), mail VARCHAR(60), compte BOOLEAN, date_adaptation DATE, date_contrat DATE, num_contrat VARCHAR(30) UNIQUE, indice_p INT, tva_s BOOLEAN, pension_c FLOAT, prc_demi_pension INT, taxe_sejour FLOAT, etoile INT, description TEXT, parametre_gps VARCHAR(500))

	//----------------------insert-----------------------------//
		DROP PROCEDURE apresHotelInsr;
DELIMITER |   
			CREATE PROCEDURE apresHotelInsr(IN codeH varchar(200), IN hotel varchar(500), IN tel varchar(14), IN email varchar(30))
			BEGIN
                         DECLARE nbUsers INT DEFAULT 0 ;
                         select count(code_u) into nbUsers from MH_COMPTE_USER_H where code_h like codeH;

                         IF(nbUsers = 0)THEN
				insert into MH_COMPTE_USER_H values (codeH, 'Administrateur', codeH, hotel, email, codeH, true, tel);
                         END IF;           
                END|
		DELIMITER;
		
		DELIMITER $$

				CREATE TRIGGER trigger_MH_HOTEL
				AFTER INSERT ON MH_HOTEL
				FOR EACH ROW
				BEGIN
					call apresHotelInsr(NEW.code_h, NEW.raison_social) ;
				END $$

		DELIMITER  ;
	//----------------------update-----------------------------//	
	
	//----------------------delete-----------------------------//		
	

2)		CREATE TABLE MH_AGENCE ( code_a VARCHAR(200) UNIQUE NOT NULL PRIMARY KEY, raison_social VARCHAR(500), adresse VARCHAR(2000), Commune VARCHAR(80), wilaya VARCHAR(80), code_postal VARCHAR(20), nrc VARCHAR(30) UNIQUE, nif VARCHAR(50), nai VARCHAR(50), rib VARCHAR(100), tel VARCHAR(25), fax VARCHAR(25), mail VARCHAR(60), compte BOOLEAN, date_adaptation DATE, date_contrat DATE, num_contrat VARCHAR(30) UNIQUE, indice_p INT, description TEXT, parametre_gps VARCHAR(500))
	//-----agence par default recherche sur code_h seulement sinon la réservation et depuis l'agence-----//
	    insert into MH_CLT_FCT values ("--------", "--------", "--------", "--------", "--------", "--------","--------","--------","--------","--------","123456789","123456789","agence@agence.agc", true, "1970-01-01", "1970-01-01", "CRT0", 0, 'reservation sans agence', 'vide') ;
	
	//----------------------insert-----------------------------//
		DELIMITER |   
			CREATE PROCEDURE apresAgenceInsr(IN code_a varchar(200), IN agence varchar(500), IN tel varchar(14)) 
			BEGIN
				insert into MH_COMPTE_USER_A values (code_a, 'admin', code_a, agence, agence, code_a, true, tel) ;
			END|
		DELIMITER ;
		
		DELIMITER $$

				CREATE TRIGGER trigger_MH_AGENCE
				AFTER INSERT ON MH_AGENCE
				FOR EACH ROW
				BEGIN
					call apresAgenceInsr(NEW.code_a, NEW.raison_social) ;
				END $$

		DELIMITER  ;
	//----------------------update-----------------------------//	
	
	//----------------------delete-----------------------------//
	
3)		CREATE TABLE MH_CHAMBRE ( code_h VARCHAR(200), num_ch VARCHAR(300) UNIQUE NOT NULL PRIMARY KEY, nb_place INT, prix FLOAT, prc_gain_agc INT, type_ch VARCHAR(100), visible BOOLEAN)
		
			ALTER TABLE mh_chambre
			ADD CONSTRAINT fk_code_h_chambre FOREIGN KEY (code_h) REFERENCES mh_hotel(code_h)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
			
			ALTER TABLE mh_chambre
			ADD CONSTRAINT FK_code_r_chambre FOREIGN KEY (code_r) REFERENCES MH_RESERVATION(code_r)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
	//----------------------insert-----------------------------//			
		
	//----------------------update-----------------------------//	
	
	//----------------------delete-----------------------------//	
		
4)		CREATE TABLE MH_COMPTE_USER_H ( code_h VARCHAR(200), type_user VARCHAR(20), code_u VARCHAR(20) UNIQUE NOT NULL PRIMARY KEY, nom VARCHAR(200), email VARCHAR(100) UNIQUE, psw VARCHAR(100), admin BOOLEAN, tel VARCHAR(25))

			ALTER TABLE MH_COMPTE_USER_H
			ADD CONSTRAINT fk_code_h_COMPTE_USER_H FOREIGN KEY (code_h) REFERENCES mh_hotel(code_h)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
	//----------------------insert-----------------------------//			
		
	//----------------------update-----------------------------//	
	
	//----------------------delete-----------------------------//				
		
5)		CREATE TABLE MH_CLT_FCT ( raison_sociale VARCHAR(200), nrc VARCHAR(80) UNIQUE, nif VARCHAR(80), nai VARCHAR(80), adresse VARCHAR(2000), tel VARCHAR(30), exonore BOOLEAN, code_c VARCHAR(100) UNIQUE NOT NULL PRIMARY KEY)
        ****client par défault****       
	    insert into MH_CLT_FCT values ("--------", "--------", "--------", "--------", "--------", "--------", false, "123456") ;
	//----------------------insert-----------------------------//			
		
	//----------------------update-----------------------------//	
	
	//----------------------delete-----------------------------//			
		
		ALTER TABLE rsv_clt_sch
			ADD CONSTRAINT fk_npid_rsv_clt_sch FOREIGN KEY (npid) REFERENCES MH_CLT_S_CH(npid)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
		
		
		
6)		CREATE TABLE MH_CLT_S_CH ( nom_prenom VARCHAR(500), code_c VARCHAR(100), date_n DATE, lieu_n VARCHAR(500), nationalite VARCHAR(200), p_id VARCHAR(80), n_p_id VARCHAR(200) UNIQUE, date_p DATE, lien_p VARCHAR(80), adresse VARCHAR(4000), num_tel VARCHAR(30), code_r VARCHAR(200), code_h VARCHAR(200), liste_noir BOOLEAN, raison_ln VARCHAR(500))		
		
			ALTER TABLE MH_CLT_S_CH
			ADD CONSTRAINT fk_code_c_CLT_S_CH FOREIGN KEY (code_c) REFERENCES MH_CLT_FCT(code_c)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
			
			ALTER TABLE MH_CLT_S_CH
			ADD CONSTRAINT FK_code_r_CLT_S_CH FOREIGN KEY (code_r) REFERENCES MH_RESERVATION(code_r)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
		
			ALTER TABLE MH_CLT_S_CH
			ADD CONSTRAINT fk_code_h_CLT_S_CH FOREIGN KEY (code_h) REFERENCES mh_hotel(code_h)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
			
			ALTER TABLE MH_CLT_S_CH
			ADD CONSTRAINT fk_NUM_CH_CLT_S_CH FOREIGN KEY (NUM_CH) REFERENCES mh_CHAMBRE(NUM_CH)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
	//----------------------insert-----------------------------//			
		
	//----------------------update-----------------------------//	
	
	//----------------------delete-----------------------------//	
	
		
7)		CREATE TABLE MH_RESERVATION ( code_h VARCHAR(200), num_ch VARCHAR(300), code_c VARCHAR(100), code_a VARCHAR(200), code_u VARCHAR(200), date_a DATE, date_d DATE,  periode_ouverte BOOLEAN, nb_nuitee INT, pension VARCHAR(20), prix_u FLOAT, versement FLOAT, etat_p BOOLEAN, code_r VARCHAR(250) UNIQUE NOT NULL PRIMARY KEY, date_r TIMESTAMP, nb_prs INT)
		    
			ALTER TABLE MH_RESERVATION
			ADD CONSTRAINT fk_code_h_RESERVATION FOREIGN KEY (code_h) REFERENCES mh_hotel(code_h)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
			
			ALTER TABLE MH_RESERVATION
			ADD CONSTRAINT fk_num_ch_RESERVATION FOREIGN KEY (num_ch) REFERENCES mh_chambre(num_ch)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
		
			ALTER TABLE MH_RESERVATION
			ADD CONSTRAINT fk_code_c_RESERVATION FOREIGN KEY (code_c) REFERENCES MH_CLT_FCT(code_c)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
			
			ALTER TABLE MH_RESERVATION
			ADD CONSTRAINT fk_code_a_RESERVATION FOREIGN KEY (code_a) REFERENCES mh_agence(code_a)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
		
			ALTER TABLE MH_RESERVATION
			ADD CONSTRAINT fk_code_u_RESERVATION FOREIGN KEY (code_u) REFERENCES MH_COMPTE_USER_H(code_u)
			ON DELETE SET NULL ON UPDATE CASCADE ;
	
	//----------------------insert-----------------------------//		

						
////////////////////////////////////////////////////////////////////////////////////////////////////

DROP PROCEDURE DROITINSERT;
DELIMITER |
CREATE PROCEDURE DROITINSERT (IN CH VARCHAR(200), IN CU VARCHAR(200))
BEGIN 
DECLARE 
any_rows_found INT DEFAULT 0;

    select count(*) into any_rows_found from mh_users_droits where code_h like CH and code_u like CU;
    
 IF(any_rows_found < 1) THEN
     insert into mh_users_droits(code_h, code_u, chambre, compteUser, informationPerso, clients, entreprises, reservation, chargeSupp, liberation, versement, gestionCaisse, facturation, calendrier, statistique, listePolice)values(CH,CU, false, false, false, false, false, false, false, false, false, false, false, false, false, false);
    END IF;
END | 
DELIMITER ; 

DROP PROCEDURE DROITDELETE;
DELIMITER |
CREATE PROCEDURE DROITDELETE (IN CH VARCHAR(200), IN CU VARCHAR(200))
BEGIN 
    delete from mh_users_droits where code_h like CH and code_u like CU;
END | 
DELIMITER; 

DELIMITER $$    
	CREATE TRIGGER trigger_mh_compte_user_h_UPDATE
		BEFORE UPDATE ON mh_compte_user_h
                        FOR EACH ROW
				BEGIN
                                    IF(OLD.type_user = 'Opérateur' )THEN
                                        call DROITINSERT(OLD.code_h, OLD.code_u) ;
                                    ELSE
                                        call DROITDELETE(OLD.code_h, OLD.code_u) ;
                                    END IF;
				END $$
                        DELIMITER ;

//--------------------------------

DROP PROCEDURE VRSOMTOCAISSE ;
DELIMITER |
CREATE PROCEDURE VRSOMTOCAISSE (IN CH VARCHAR(200),IN CU VARCHAR(200), IN MOTIF VARCHAR(200),IN SOM FLOAT, IN CR VARCHAR(200))
BEGIN 
    insert into mh_caisse(code_h, code_r, code_u, dates, motif, somme)values(CH, CR, CU, NOW(), MOTIF, SOM) ;
END | 
DELIMITER  ; 

DROP PROCEDURE RETIRSOMTOCAISSE ;
DELIMITER |
CREATE PROCEDURE RETIRSOMTOCAISSE (IN CH VARCHAR(200), IN MOTIF VARCHAR(200),IN CR VARCHAR(200))
BEGIN 
    delete from mh_caisse where code_h like CH and code_r like CR and motif like MOTIF ;
END | 
DELIMITER  ; 

DROP PROCEDURE UPDSOMTOCAISSE ;
DELIMITER |
CREATE PROCEDURE UPDSOMTOCAISSE (IN CH VARCHAR(200), IN CR VARCHAR(200), IN SOM FLOAT)
BEGIN 
    update mh_caisse set somme = SOM where code_h like CH and code_r like CR and motif like 'RESERVATION' ;
END | 
DELIMITER  ; 



						DELIMITER $$    
						CREATE TRIGGER trigger_MH_RESERVATION_INS
							AFTER INSERT ON MH_RESERVATION
								FOR EACH ROW
									BEGIN
									 IF(new.code_u IS NOT NULL)THEN
										call VRSOMTOCAISSE(new.code_h,new.code_u, 'RESERVATION',new.versement, new.code_r) ;
									 END IF ;
									END $$
                        DELIMITER  ;
						
						DELIMITER $$    
								CREATE TRIGGER trigger_MH_RESERVATION_DLT
								BEFORE DELETE ON MH_RESERVATION
								FOR EACH ROW
								BEGIN
									
									CALL RETIRSOMTOCAISSE(OLD.code_h, 'RESERVATION', OLD.code_r) ;
									
                                END $$
                        DELIMITER  ;
						
						DELIMITER $$

								CREATE TRIGGER monhotel.trigger_MH_RESERVATION_UPD
								BEFORE UPDATE ON monhotel.mh_reservation
								FOR EACH ROW
								BEGIN
																	
												CALL UPDSOMTOCAISSE(OLD.code_h, OLD.code_r, NEW.versement) ;
																	
								END $$
						DELIMITER  ; 

/---------------------------------------------------------------------------------------------------------------						

DELIMITER $$    
						CREATE TRIGGER trigger_MH_CHARGE_INS
							AFTER INSERT ON MH_CHARGE_SUPP
								FOR EACH ROW
									BEGIN
									 
										call VRSOMTOCAISSE(new.code_h,null, new.charge ,new.prix_ch, new.code_r) ;
									
									END $$
                        DELIMITER  ;
						
						DELIMITER $$    
								CREATE TRIGGER trigger_MH_CHARGE_DLT
								BEFORE DELETE ON MH_CHARGE_SUPP
								FOR EACH ROW
								BEGIN
									
									CALL RETIRSOMTOCAISSE(OLD.code_h, OLD.charge, OLD.code_r) ;
									
                                END $$
                        DELIMITER  ;
						
						

///////////////////////////////////////////////////////////////////////////////////////////////////////

DROP PROCEDURE GETSUMVERS ;
DELIMITER |
CREATE PROCEDURE GETSUMVERS (IN CH VARCHAR(200),IN CA VARCHAR(200),IN CR VARCHAR(200), OUT SOMME FLOAT)
BEGIN 
    select SUM(versement) into SOMME from MH_DETTE_AGC_HTL where CODE_R like CR and CODE_H like CH and CODE_A like CA ;
	IF(SOMME IS NULL)THEN 
	 set SOMME = 0 ;
	END IF ; 
END | 
DELIMITER  ; 


DROP PROCEDURE SOLDE_VERIF ;
DELIMITER |
CREATE PROCEDURE SOLDE_VERIF(IN code_a VARCHAR(200), IN code_h VARCHAR(250),IN code_r VARCHAR(250),IN TOT_HT FLOAT)
BEGIN
  
    DECLARE soldeVR FLOAT DEFAULT 0 ;
    DECLARE num_v VARCHAR(200) ;

    DECLARE fin BOOLEAN DEFAULT FALSE ;
                                 
                                  DECLARE curs CURSOR 
                                  FOR SELECT SOLDE, NUM_VERS 
                                  FROM MH_AGC_HTL_SOLDE 
                                  where CODE_A like code_a and CODE_H like code_h ;
                                  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE ;                     
    

									OPEN curs ;                                    
									loop_curs: LOOP    
									FETCH curs INTO soldeVR, num_v ; 						
											IF fin THEN 
												LEAVE loop_curs ;
											END IF ;  
											
												IF(soldeVR > TOT_HT)THEN
													INSERT INTO mh_dette_agc_htl values (code_r, code_h, code_a, TOT_HT, TOT_HT, NOW(), num_v) ;
													UPDATE MH_AGC_HTL_SOLDE set SOLDE = soldeVR - TOT_HT where CODE_H like code_h and CODE_R like code_r and NUM_VERS like num_v ;
												ELSE
													INSERT INTO mh_dette_agc_htl values (code_r, code_h, code_a, TOT_HT, soldeVR, NOW(), num_v) ;
													DELETE FROM MH_AGC_HTL_SOLDE where CODE_H like code_h and CODE_R like code_r and NUM_VERS like num_v ;
												END IF ;	
	
									END LOOP ;
									CLOSE curs ; 

								END|
								DELIMITER  ;
//-----------------------------------------------------------------------------------------
DROP PROCEDURE detteAgcHtl ;
                            DELIMITER |   
							CREATE PROCEDURE detteAgcHtl(IN code_r varchar(250), IN num_ch varchar(300), IN nb_nuitee INT, pension VARCHAR(20),IN code_h VARCHAR(200),IN code_a VARCHAR(100), IN nb_prs INT, IN PRIX_CH FLOAT) 
							BEGIN
								DECLARE TOT_HT FLOAT DEFAULT 0 ;
								DECLARE pension_NB FLOAT DEFAULT 0 ;
								DECLARE prc INT DEFAULT 0 ;
								
								DECLARE cnt INT DEFAULT 0 ;
								  
									SELECT PENSION_C , prc_demi_pension INTO pension_NB, prc FROM mh_hotel WHERE CODE_H like code_h ;
												IF(pension = 'DEMI') THEN
												  set pension_NB = pension_NB*(prc/100) ; 
												ELSEIF (pension = 'COMPLETE')THEN
												  set pension_NB = pension_NB*1 ;
												ELSE
												  set pension_NB = pension_NB ;
												END IF ;
											set TOT_HT = (nb_nuitee*PRIX_CH) + (nb_prs*nb_nuitee*pension_NB) ;
											
                                                SELECT count(SOLDE) into cnt FROM MH_AGC_HTL_SOLDE where CODE_A like code_a and CODE_H like code_h ;
										        
												call SOLDE_VERIF(code_a, code_h, code_r, TOT_HT) ;	
											
											IF(cnt = 0)THEN
											    insert into MH_DETTE_AGC_HTL values ( code_r, code_h, code_a, TOT_HT, 0, '1970-01-01', NULL) ; 
											END IF ;
								END|
						DELIMITER ;
///////////////////////////////////////////////////////////////////////////////////////////////						
						DROP TRIGGER trigger_MH_RESERVATION_INS ;
						DELIMITER $$    
								CREATE TRIGGER trigger_MH_RESERVATION_INS
								AFTER INSERT ON MH_RESERVATION
								FOR EACH ROW
								BEGIN
									
									IF(NEW.code_a IS NOT NULL)THEN
										 DELETE FROM mh_agc_htl_solde where SOLDE = 0 and code_h like NEW.code_h and code_a like NEW.code_a ;
										 insert into mh_vers_details values(NEW.code_h, NEW.code_a, NULL, NEW.code_r, NEW.versement, CURDATE()) ;
										 call detteAgcHtl(NEW.code_r, NEW.num_ch, NEW.nb_nuitee, NEW.pension,NEW.code_h,NEW.code_a, NEW.nb_prs, NEW.prix_u) ;
								    ELSE
										 insert into mh_vers_details values(NEW.code_h, NULL, NEW.code_u, NEW.code_r, NEW.versement, CURDATE()) ;
									END IF ;
                                END $$
                        DELIMITER  ;

						
						

	//----------------------update-----------------------------//	
	
	
	    DROP PROCEDURE detteAgcHtl_maj ;
                              DELIMITER |   
							CREATE PROCEDURE detteAgcHtl_maj(IN code_r varchar(250), IN num_ch varchar(300), IN nb_nuitee INT, pension VARCHAR(20),IN code_h VARCHAR(200),IN code_a VARCHAR(100), IN nb_prs INT) 
							BEGIN
								DECLARE PRIX_CH FLOAT DEFAULT 0 ;
								DECLARE TOT_HT FLOAT DEFAULT 0 ;
								DECLARE pension_NB FLOAT DEFAULT 0 ;
								DECLARE prc INT DEFAULT 0 ;

									SELECT PRIX INTO PRIX_CH FROM mh_chambre WHERE NUM_CH like num_ch and CODE_H like code_h ;
									SELECT PENSION_C , prc_demi_pension INTO pension_NB, prc FROM mh_hotel WHERE CODE_H like code_h ;
									
												IF(pension = 'DEMI') THEN
												  set pension_NB = pension_NB*(prc/100) ; 
												ELSEIF (pension = 'COMPLETE')THEN
												  set pension_NB = pension_NB*1 ;
												ELSE
												  set pension_NB = pension_NB ;
												END IF ;
											
											set TOT_HT = (nb_nuitee*PRIX_CH) + (nb_prs*nb_nuitee*pension_NB) ;
											UPDATE MH_DETTE_AGC_HTL SET total_ht = TOT_HT WHERE CODE_H like code_h and CODE_R like code_r ;
								END|
						DELIMITER ;


	
						DELIMITER $$    
								CREATE TRIGGER trigger_MH_RESERVATION_MAJ
								AFTER UPDATE ON MH_RESERVATION
								FOR EACH ROW
								BEGIN
									IF(NEW.code_a IS NOT NULL)THEN
									   call detteAgcHtl_maj(NEW.code_r, NEW.num_ch, NEW.nb_nuitee, NEW.pension,NEW.code_h,NEW.code_a, NEW.nb_prs) ;
									END IF ;
                                END $$
                        DELIMITER  ;
	
	
	//----------------------delete-----------------------------//	

						 DROP PROCEDURE avantResDel ;
                                                DELIMITER |   
							CREATE PROCEDURE avantResDel(IN code_r0 varchar(200), IN date_r timestamp) 
							BEGIN
								DECLARE cd_r INT DEFAULT  0 ;
								DECLARE vers FLOAT DEFAULT  0 ;
								DECLARE nb_heures INT DEFAULT  0 ;
								DECLARE dt_act timestamp DEFAULT  NOW() ;

												SELECT COUNT(CODE_R) INTO cd_r FROM mh_facturation WHERE CODE_R LIKE code_r0 ;
												SELECT versement INTO vers FROM mh_dette_agc_htl WHERE CODE_R LIKE code_r0 ;
												
													IF(cd_r = 0 AND vers = 0)THEN 
															SELECT TIMESTAMPDIFF(HOUR,date_r, NOW()) INTO nb_heures ;
															IF(nb_heures < 24)THEN
																DELETE FROM mh_clt_s_ch WHERE CODE_R LIKE code_r0 ;
																DELETE FROM mh_vers_details WHERE CODE_R LIKE code_r0 ;
																DELETE FROM mh_dette_agc_htl where CODE_R like code_r0 ;
															END IF ;
													END IF ;  
										END|
						DELIMITER ;
	
	
						DELIMITER $$    
								CREATE TRIGGER trigger_MH_RESERVATION_DLT
								BEFORE DELETE ON MH_RESERVATION
								FOR EACH ROW
								BEGIN
									
									CALL avantResDel(OLD.code_r, OLD.date_r) ;
									
                                END $$
                        DELIMITER  ;
	
	
	
//----il faut ajouter un déclancheur pour la modification de la valeur sur la réservation aprés l'update de la valeur des détails de versement table suivante: 

8)		CREATE TABLE MH_VERS_DETAILS ( code_h VARCHAR(200), code_a VARCHAR(200), code_u VARCHAR(200), code_r VARCHAR(250), montant FLOAT, date_v DATE)
			
			ALTER TABLE MH_VERS_DETAILS
			ADD CONSTRAINT fk_code_h_VERS_DETAILS FOREIGN KEY (code_h) REFERENCES mh_hotel(code_h)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
			
			ALTER TABLE MH_VERS_DETAILS
			ADD CONSTRAINT fk_code_a_VERS_DETAILS FOREIGN KEY (code_a) REFERENCES mh_agence(code_a)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
			
			ALTER TABLE MH_VERS_DETAILS
			ADD CONSTRAINT fk_code_r_VERS_DETAILS FOREIGN KEY (code_r) REFERENCES MH_RESERVATION(code_r)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
			
			
//------------------------------------------------------------			
			
			
			
			ALTER TABLE mh_pub_particulier
			ADD CONSTRAINT fk_n_p_id_pub_particulier FOREIGN KEY (n_p_id) REFERENCES mh_clt_s_ch(n_p_id)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
			
	//----------------------insert-----------------------------//			
		
	//----------------------update-----------------------------//	
	
	//----------------------delete-----------------------------//	

9)		CREATE TABLE MH_DETTE_AGC_HTL ( code_r VARCHAR(200), code_h VARCHAR(200), code_a VARCHAR(200), total_ht FLOAT, versement FLOAT, date_rcp_v DATE, num_vers VARCHAR(200) NOT NULL) 
			
			ALTER TABLE MH_DETTE_AGC_HTL
			ADD CONSTRAINT fk_code_r_DETTE_AGC_HTL FOREIGN KEY (code_r) REFERENCES MH_RESERVATION(code_r)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
			
			ALTER TABLE MH_DETTE_AGC_HTL
			ADD CONSTRAINT fk_code_h_DETTE_AGC_HTL FOREIGN KEY (code_h) REFERENCES mh_hotel(code_h)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
			
			ALTER TABLE MH_DETTE_AGC_HTL
			ADD CONSTRAINT fk_code_a_DETTE_AGC_HTL FOREIGN KEY (code_a) REFERENCES mh_agence(code_a)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
			
			ALTER TABLE MH_DETTE_AGC_HTL
			ADD CONSTRAINT fk_num_vers_DETTE_AGC_HTL FOREIGN KEY (num_vers) REFERENCES MH_VRS_DTL_AGC(num_vers)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
			
	//----------------------insert-----------------------------//			
		
	//----------------------update-----------------------------//	
	
	//----------------------delete-----------------------------//			

10)		CREATE TABLE MH_VRS_DTL_AGC ( code_h VARCHAR(200), code_a VARCHAR(200), montant FLOAT, date_v DATE, num_vers VARCHAR(200) NOT NULL UNIQUE, confirmation BOOLEAN, type_versement  VARCHAR(50), pieceLink varchar(200)) 
		
			ALTER TABLE MH_VRS_DTL_AGC
			ADD CONSTRAINT fk_code_h_VRS_DTL_AGC FOREIGN KEY (code_h) REFERENCES mh_hotel(code_h)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
			
			ALTER TABLE MH_VRS_DTL_AGC
			ADD CONSTRAINT fk_code_a_VRS_DTL_AGC FOREIGN KEY (code_a) REFERENCES mh_agence(code_a)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
		
	//----------------------insert-----------------------------//			
		
	//----------------------update-----------------------------//
				DROP TRIGGER trigger_VRS_DTL_AGC_UPD ;
						DELIMITER $$
						
						CREATE TRIGGER trigger_VRS_DTL_AGC_UPD
						BEFORE UPDATE ON mh_vrs_dtl_agc
						FOR EACH ROW
						BEGIN
							IF((OLD.CONFIRMATION <> NEW.CONFIRMATION) AND (NEW.CONFIRMATION = true)) THEN 
							    CALL trueExecut(NEW.code_h, NEW.code_a, NEW.montant, NEW.num_vers) ;    
							END IF ;

						END $$
						DELIMITER  ; 				
				
				DROP PROCEDURE trueExecut ;
				DELIMITER |
				CREATE PROCEDURE trueExecut(IN CH VARCHAR(200),IN CA VARCHAR(200), IN MONTANT FLOAT, IN NUM_VERS VARCHAR(200))
					BEGIN 
						INSERT INTO mh_agc_htl_solde VALUES (CA, CH, MONTANT, NUM_VERS) ;
					END|
					DELIMITER  ;
	
	
	//----------------------delete-----------------------------//	
		
11)		CREATE TABLE MH_FACTURATION ( code_h VARCHAR(200), code_r VARCHAR(200), num_v INT, designation VARCHAR(500), nb_ch INT, nb_nuitee INT, nb_personne INT, prix FLOAT, code_c VARCHAR(100), date_fct DATE, etat BOOLEAN, type_pmt VARCHAR(20), num_fct VARCHAR(20) NOT NULL, pension_val FLOAT, taxe_sejour INT)
		
			ALTER TABLE MH_FACTURATION
			ADD CONSTRAINT fk_code_h_FACTURATION FOREIGN KEY (code_h) REFERENCES mh_hotel(code_h)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
			
			ALTER TABLE MH_FACTURATION
			ADD CONSTRAINT fk_code_r_FACTURATION FOREIGN KEY (code_r) REFERENCES MH_RESERVATION(code_r)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
			
			ALTER TABLE MH_FACTURATION
			ADD CONSTRAINT fk_code_c_FACTURATION FOREIGN KEY (code_c) REFERENCES MH_CLT_FCT(code_c)
			ON DELETE NO ACTION ON UPDATE CASCADE ;

	//----------------------insert-----------------------------//			
		
	//----------------------update-----------------------------//	
	
	//----------------------delete-----------------------------//				
		
12)		CREATE TABLE MH_HTL_CAISSE ( code_h VARCHAR(200), type_opr VARCHAR(10), designation VARCHAR(400), montant FLOAT, dates DATE, sujet_mouv VARCHAR(50))
		
			ALTER TABLE MH_HTL_CAISSE
			ADD CONSTRAINT fk_code_h_HTL_CAISSE FOREIGN KEY (code_h) REFERENCES mh_hotel(code_h)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
			
	//----------------------insert-----------------------------//			
		
	//----------------------update-----------------------------//	
	
	//----------------------delete-----------------------------//	
	
13)		CREATE TABLE MH_PUB_HTL ( code_h VARCHAR(200), indice_p INT, sujet VARCHAR(200), contenu VARCHAR(4000), date_pub DATE, validation BOOLEAN, num_pub_j INT)
		
			ALTER TABLE MH_PUB_HTL
			ADD CONSTRAINT fk_code_h_PUB_HTL FOREIGN KEY (code_h) REFERENCES mh_hotel(code_h)
			ON DELETE NO ACTION ON UPDATE CASCADE ;

	//----------------------insert-----------------------------//			
		
	//----------------------update-----------------------------//	
	
	//----------------------delete-----------------------------//	
	
14)		CREATE TABLE MH_ACTION_HTL ( code_h VARCHAR(200), code_u VARCHAR(200), action VARCHAR(800), date_opr DATE, val_opr VARCHAR(20))
		
			ALTER TABLE MH_ACTION_HTL
			ADD CONSTRAINT fk_code_h_ACTION_HTL FOREIGN KEY (code_h) REFERENCES mh_hotel(code_h)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
			
			ALTER TABLE MH_ACTION_HTL
			ADD CONSTRAINT fk_code_u_ACTION_HTL FOREIGN KEY (code_u) REFERENCES MH_COMPTE_USER_H(code_u)
			ON DELETE SET NULL ON UPDATE CASCADE ;

	//----------------------insert-----------------------------//			
		
	//----------------------update-----------------------------//	
	
	//----------------------delete-----------------------------//	
			
15)		CREATE TABLE MH_COMPTE_USER_A ( code_a VARCHAR(200), type_user VARCHAR(20), code_u VARCHAR(20) UNIQUE NOT NULL PRIMARY KEY, nom VARCHAR(200), email VARCHAR(100) UNIQUE, psw VARCHAR(100), admin BOOLEAN, tel VARCHAR(25))

			ALTER TABLE MH_COMPTE_USER_A
			ADD CONSTRAINT fk_code_a_COMPTE_USER_A FOREIGN KEY (code_a) REFERENCES mh_agence(code_a)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
			
	//----------------------insert-----------------------------//			
		
	//----------------------update-----------------------------//	
	
	//----------------------delete-----------------------------//				
	

16)		CREATE TABLE MH_AGC_HTL_SOLDE ( code_a VARCHAR(200), code_h VARCHAR(250), solde FLOAT, num_vers VARCHAR(200) NOT NULL) ;

			ALTER TABLE MH_AGC_HTL_SOLDE
			ADD CONSTRAINT fk_code_a_AGC_HTL_SOLDE FOREIGN KEY (code_a) REFERENCES mh_agence(code_a)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
			
			ALTER TABLE MH_AGC_HTL_SOLDE
			ADD CONSTRAINT fk_code_h_AGC_HTL_SOLDE FOREIGN KEY (code_h) REFERENCES mh_hotel(code_h)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
			
			ALTER TABLE MH_AGC_HTL_SOLDE
			ADD CONSTRAINT fk_num_vers_AGC_HTL_SOLDE FOREIGN KEY (num_vers) REFERENCES MH_VRS_DTL_AGC(num_vers)
			ON DELETE NO ACTION ON UPDATE CASCADE ;
			
	//----------------------insert-----------------------------//			
		DROP TRIGGER trigger_VRS_NEW_SOLDE ;
						DELIMITER $$
						
						CREATE TRIGGER trigger_VRS_NEW_SOLDE
						BEFORE INSERT ON mh_agc_htl_solde
						FOR EACH ROW
						BEGIN
						 DECLARE SUB FLOAT DEFAULT 0 ;
						 call SiInsertSolde( new.code_h , new.code_a,  new.solde ,  new.num_vers, @SUB) ;
						  SELECT @SUB into SUB ;
                                                  IF(SUB > 0)THEN
                                                        set new.SOLDE = SUB ; 
                                                  ELSE
                                                        set new.SOLDE = 0 ;
                                                  END IF ;  
						END $$
						DELIMITER ; 

						
					
						
				
				DROP PROCEDURE SiInsertSolde ;
				DELIMITER |
				CREATE PROCEDURE SiInsertSolde(IN CH VARCHAR(200),IN CA VARCHAR(200), IN MONTANT FLOAT, IN NUM_VERS VARCHAR(200), OUT SUB FLOAT)
					BEGIN 
					
					 DECLARE THT FLOAT DEFAULT 0 ;
					 DECLARE RESTE FLOAT DEFAULT 0 ;	
					 DECLARE VERS_RESERVATION FLOAT DEFAULT 0 ;					 
					 DECLARE NVERS VARCHAR(200) ;
					 DECLARE CR VARCHAR(200) ;
					 DECLARE DT_ACT DATE ;
					 DECLARE fin  BOOLEAN DEFAULT FALSE ;
					 
								  DECLARE curs CURSOR FOR 
								  SELECT code_r, total_ht 
                                  FROM mh_dette_agc_htl 
                                  where total_ht > (select SUM(versement) from mh_dette_agc_htl where CODE_A like CA and CODE_H like CH)  ;
                                  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE ;                       

									OPEN curs ;                                    
										loop_curs: LOOP    
															FETCH curs INTO CR, THT ;						
																IF fin THEN 
																	LEAVE loop_curs ;
																END IF ;   
																
									 	select SUM(versement) into VERS_RESERVATION from mh_dette_agc_htl where CODE_R like CR ;				
										
										IF (VERS_RESERVATION IS NULL) THEN
										 set VERS_RESERVATION = 0 ;
										END IF ;
										
										set RESTE = THT - VERS_RESERVATION ;
										
									IF(RESTE > 0)THEN
									    SELECT distinct date_rcp_v into DT_ACT from mh_dette_agc_htl where code_r like CR ; 

										IF(MONTANT > RESTE)THEN
														IF( DT_ACT <> '1970-01-01' )THEN
															INSERT INTO mh_dette_agc_htl values (CR, CH, CA, THT, RESTE, NOW(), NUM_VERS) ;
														ELSE
															UPDATE mh_dette_agc_htl set num_vers = NUM_VERS, versement = RESTE, date_rcp_v = NOW() where code_r like CR  ;
														END IF ;
											set MONTANT = MONTANT - RESTE ;
                                                                                        set SUB = MONTANT ;
										ELSE
														IF( DT_ACT <> '1970-01-01')THEN
															INSERT INTO mh_dette_agc_htl values (CR, CH, CA, THT, MONTANT, NOW(), NUM_VERS) ;
														ELSE
															UPDATE mh_dette_agc_htl set num_vers = NUM_VERS, versement = MONTANT, date_rcp_v = NOW() where code_r like CR  ;
														END IF ;
											--DELETE FROM mh_agc_htl_solde WHERE NUM_VERS like NUM_VERS ;
                                                                                        set SUB = 0 ;
										END IF ;
									END IF ;

										END LOOP ;
									CLOSE curs ;
								
                                                                        
						
					END|
					DELIMITER  ;
	//----------------------update-----------------------------//	
	
	//----------------------delete-----------------------------//				
	
		
	
	// ---------- Les VUES----------//

CREATE OR REPLACE VIEW mh_RsvVueGlobal AS
select mh_reservation.num_ch, rsv_clt_sch.npid, mh_clt_s_ch.nom_prenom ,mh_reservation.date_a, mh_reservation.date_d,mh_reservation.code_r, mh_reservation.date_r, mh_rsv_fct.numFct, mh_rsv_fct.designation, mh_rsv_fct.type_paiement, mh_rsv_fct.dates, mh_rsv_fct.numCheque, mh_rsv_fct.remarque, mh_rsv_fct.prcReduction,mh_reservation.prix_u, mh_reservation.pension, mh_reservation.nb_nuitee, mh_reservation.versement, mh_reservation.code_h, mh_reservation.code_c, mh_reservation.taxe_sj, mh_reservation.pension_c, mh_reservation.prc_pension
from mh_reservation, rsv_clt_sch,mh_rsv_fct, mh_clt_s_ch
where mh_reservation.code_r = rsv_clt_sch.code_r and mh_rsv_fct.code_r = mh_reservation.code_r and mh_clt_s_ch.n_p_id = rsv_clt_sch.npid;


CREATE OR REPLACE VIEW mhRsvVueGlobal_A AS
select mh_reservation.num_ch, rsv_clt_sch.npid, mh_clt_s_ch.nom_prenom ,mh_reservation.date_a, mh_reservation.date_d,mh_reservation.code_r, mh_reservation.date_r, mh_rsv_fct.numFct, mh_rsv_fct.designation, mh_rsv_fct.type_paiement, mh_rsv_fct.prcReduction, mh_reservation.prix_u, mh_reservation.pension, mh_reservation.nb_nuitee, mh_reservation.versement, mh_reservation.code_h, mh_reservation.code_c, mh_reservation.taxe_sj, mh_reservation.pension_c, mh_reservation.prc_pension
from mh_reservation, rsv_clt_sch,mh_rsv_fct, mh_clt_s_ch
where mh_reservation.code_r = rsv_clt_sch.code_r and mh_rsv_fct.code_r = mh_reservation.code_r and mh_clt_s_ch.n_p_id = rsv_clt_sch.npid;	
	

CREATE OR REPLACE VIEW mhRsvVue_WOutFct AS
select mh_reservation.num_ch, rsv_clt_sch.npid, mh_clt_s_ch.nom_prenom ,mh_reservation.date_a, mh_reservation.date_d, mh_reservation.periode_ouverte, mh_reservation.code_r, mh_reservation.date_r, mh_reservation.prix_u, mh_reservation.pension, mh_reservation.nb_nuitee, mh_reservation.versement, mh_reservation.code_h, mh_reservation.taxe_sj, mh_reservation.pension_c, mh_reservation.prc_pension,concat(rsv_clt_sch.npid, mh_reservation.code_r) AS ident
from mh_reservation, rsv_clt_sch, mh_clt_s_ch
where mh_reservation.code_r = rsv_clt_sch.code_r  and mh_clt_s_ch.n_p_id = rsv_clt_sch.npid ;
	
	
CREATE OR REPLACE VIEW mh_vue_etat
AS SELECT MH_RESERVATION.code_h , MH_RESERVATION.num_ch , MH_RESERVATION.code_c , MH_RESERVATION.code_a , 
MH_RESERVATION.code_u , MH_RESERVATION.date_a , MH_RESERVATION.date_d ,  MH_RESERVATION.periode_ouverte , 
MH_RESERVATION.nb_nuitee , MH_RESERVATION.pension , MH_RESERVATION.prix_u , MH_RESERVATION.versement , 
MH_RESERVATION.etat_p , MH_RESERVATION.code_r , MH_RESERVATION.date_r,  
MH_CLT_S_CH.nom_prenom, MH_CLT_S_CH.p_id , MH_CLT_S_CH.n_p_id, 
MH_CHAMBRE.type_ch
FROM MH_RESERVATION, MH_CLT_S_CH, MH_CHAMBRE
WHERE MH_RESERVATION.code_r = MH_CLT_S_CH.code_r and MH_CHAMBRE.num_ch = MH_RESERVATION.num_ch and MH_CHAMBRE.visible = true ;


CREATE OR REPLACE VIEW mh_rsv_actual as
 select num_ch, npid, nom_prenom, date_a, date_d, date_r, code_h from mhRsvVue_WOutFct where date_a <= NOW() and date_d >= NOW() ;
 
 //-------------------------------------------------------------
 
 DELIMITER |
				CREATE PROCEDURE AnnuleFct(IN codeR)
					BEGIN 
						update mh_reservation set code_c = null where code_r like codeR ;
					END|
					DELIMITER  ;
-****************************************					
					DROP TRIGGER trigger_mh_rsv_fct_UPD ;
						DELIMITER $$
						
						CREATE TRIGGER trigger_mh_rsv_fct_UPD
						BEFORE DELETE ON mh_rsv_fct
								FOR EACH ROW
								BEGIN
									
									update mh_reservation set code_c = null where code_r like OLD.code_r ;
									
                                END $$
						DELIMITER  ;

//--------------------test series--------------------------------------//



delete from mh_dette_agc_htl ;
delete from mh_vrs_dtl_agc ;
delete from mh_agc_htl_solde ;
delete from mh_reservation ;



insert into mh_vrs_dtl_agc values( '1234','--------', 6000, '2018-04-08','V23421', false, 'cheque', 'c:\monhotel application') ;

insert into mh_reservation values ('1234','001','123456', '--------', null, '2018-04-03', '2018-04-05', false, 2, 'Demi', 5000.00, 1000.00, false, '123123', NOW(), 2) ;
insert into mh_clt_s_ch values ('Mahmoudi Med ElAmine', '123456', '1987-01-18', 'Annaba', 'Algerienne', 'Carte national', '74108502', '2017-05-06', 'Tarf', 'B27 LD Ramdan ati eltarf', '0670298533', '123123', '1234', false, 'no thing') ;
insert into mh_clt_s_ch values ('Harari Madjid', '123456', '1985-05-10', 'Annaba', 'Algerienne', 'Carte national', '96541280', '2017-05-06', 'Tarf', 'B21 LB Ramdan ati eltarf', '0661295002', '123123', '1234', false, 'no thing') ;
insert into mh_reservation values ('1234','001','123456', '--------', null, '2018-04-12', '2018-04-15', false, 3, 'Complette', 8000.00, 0.0, false, '124124', NOW(), 2) ;
        
//----------------------RECORD TEST PLSQL--------------------------------	

DECLARE

TYPE person IS RECORD
(
FIRST_NAME VARCHAR2(150),
LAST_NAME VARCHAR2(150)
);

prs person;

TYPE TabPerson IS TABLE OF person INDEX BY binary_integer;
tableau TabPerson;

i binary_integer := 0;
j binary_integer := 0;
begin

prs.FIRST_NAME := 'MAHMOUDI';
prs.LAST_NAME := 'MOHAMMED EL AMINE';
tableau(i) := prs;
i := i+1;
prs.FIRST_NAME := 'LAURENT';
prs.LAST_NAME := 'PAGLIARI';
tableau(i) := prs;
i := i+1;
prs.FIRST_NAME := 'GABRIEL';
prs.LAST_NAME := 'JESUS';
tableau(i) := prs;

while(j<=i)loop
  dbms_output.put_line(tableau(j).FIRST_NAME||' '||tableau(j).LAST_NAME);
  j := j+1;
end loop;  


end;
