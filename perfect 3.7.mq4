//+------------------------------------------------------------------+
//|                                                      perfect 3.7 |
//|                                    Copyright 2025 , OMID RAHMANI |
//|                                                  @theomidrahmani |
//+------------------------------------------------------------------+
//We added RVI

#property copyright "Copyright 2025 , OMID RAHMANI"
#property link      "@theomidrahmani"
#property version   "3.6"
#property description "Perfect Expert Designed and Programmed By Omid Rahmani."
#property strict

enum enum_res // RISK EQUITY SELECTOR
  {
   fixed_balance,//Fixed Balance
   account_equity,//Account Equity
   account_balance//Account Balance
  };
enum enum_co //closing option
  {
   fix_tp,//Fixed TP
   close_by_opposit,//Close By Opposit Trade
   close_by_capchannel,//Close By Cap Channel U/D
   close_by_envelopes,//Close By Envelopes U/D
   Close_by_tw_macd_slow//Close By TW MACD
  };
enum enum_cap_rfo //CAP risk free option
  {
   cap_nope,//false
   caprf_m,//Cap Channel M
   caprf_ud//Cap Channel U/D
  };
enum enum_twmacd_rfo //TW MACD risk free option
  {
   twmacd_nope,//false
   twmacd_fast,//TW MACD FAST
   twmacd_slow//TW MACD SLOW
  };  
enum enum_env_rfo //ENV risk free option
  {
   env_nope,//false
   envrf_m,//Envelopes M
   envrf_ud//Envelopes U/D
  };
enum enum_lot_control //Lot Size Control
  {
   fixed_risk,//FIXED RISK
   fixed_lot,//FIXED LOT
   negative_martingale,//NEGATIVE MARTINGALE
   positive_martingale//POSITIVE MARTINGALE
  };
enum enum_stop_calculator //SL Calculator
  {
   sl_kgsr_calculator,//CALCULATE BY KGSR
   sl_manual//MANUAL STOP
  };  
input bool do_trade_input=true;//DO TRADE
input bool do_multipletrade=false;//DO MULTIPLE TRADES OF EACH
input ENUM_TIMEFRAMES trigger_tf_input=0;//TRIGGER TIME FRAME
input enum_lot_control lot_control_input=fixed_risk;//LOT CONTROL
input double fixed_lot_input=0.01;//FIXED INPUT LOT
input double risk_input=1;//RISK %
input enum_stop_calculator stop_calculator_input=sl_kgsr_calculator;//SL CALCULATOR
input int manual_stop_pips_input=0;//MANUAL STOP PIPS
input int martingale_max_level=5;//MARTINGALE MAX LEVEL
input enum_res risk_equity_selector = account_equity;//RISK EQUITY SELECTOR
input double fixed_balance_usd=10000;//FIXED BALANCE USD
input enum_co closing_options=fix_tp; //CLOSING OPTION
input double fix_tp_risk_reward_ratio=1;//R/R for FIXED TP
input int min_stop_pips=50;//MINIMUM STOP PIPS

input string string_capchannel="---------------CAP CHANNEL---------------";//CAP CHANNEL
input bool use_capchannel=False;//USE CAP CHANNEL
input ENUM_TIMEFRAMES capchannel_tf=0;//CAP CHANNEL TIME FRAME
input int capchannel_half_length=100;//CAP CHANNEL HALF LENGTH
input ENUM_APPLIED_PRICE capchannel_price=PRICE_CLOSE;//CAP CHANNEL PRICE
input double capchannel_bands_deviation=2.0;//CAP CHANNEL BANDS DEVIATION
input int capchannel_shift=1;//CAP Shift

input string string_envelopes="---------------ENVELOPS---------------";//ENVELOPES
input bool use_envelopes=true;//USE ENVELOPES
input ENUM_TIMEFRAMES envelopes_tf=0;//ENVELOPES TIME FRAME
input int envelopes_ma_period=55;//ENVELOPES MA PERIOD
input ENUM_MA_METHOD envelopes_ma_method=MODE_SMA;//ENVELOPES MA METHOD
input int envelopes_ma_shift=1;//ENVELOPES MA SHIFT
input ENUM_APPLIED_PRICE envelopes_applied_price=PRICE_CLOSE;//ENVELOPES APPLIED PRICE
input double envelopes_deviation=0.5;//ENVELOPES DEVIATION
input int env_shift=1;//ENV Shift

input string string_macd="---------------MACD---------------";//MACD
input bool use_macd_instant=False;//USE MACD INSTANT
input bool use_macd_switch=False;//USE MACD SWITCH
input ENUM_TIMEFRAMES macd_tf=0;//MACD TIME FRAME
input int macd_fast_ma=12;//MACD FAST MA
input int macd_slow_ma=26;//MACD SLOW MA
input int macd_signal_ma=9;//MACD SIGNAL MA
input int macd_shift=1;//MACD Shift

input string string_twmacd="---------------TRADING VIEW MACD---------------";//TRADING VIEW MACD
input bool use_twmacd=False;//USE TW MACD
input ENUM_TIMEFRAMES twmacd_tf=0;//TW MACD TIME FRAME
input int twmacd_fast_ma=12;//TW MACD FAST MA
input int twmacd_slow_ma=26;//TW MACD SLOW MA
input int twmacd_signal_ma=9;//TW MACD SIGNAL MA
input ENUM_MA_METHOD twmacd_osc_method=MODE_EMA;//TW MACD OSCILATOR METHOD
input ENUM_MA_METHOD twmacd_signal_method=MODE_EMA;//TW MACD SIGNAL METHOD
input ENUM_APPLIED_PRICE twmacd_applied_price=PRICE_CLOSE;//TW MACD PRICE
input int twmacd_shift=1;//TW MACD Shift

input string string_rsi="---------------RSI---------------";//RSI
input bool use_rsi=False;//USE RSI
input ENUM_TIMEFRAMES rsi_tf=0;//RSI TIME FRAME
input int rsi_period=14;//RSI PERIOD
input ENUM_APPLIED_PRICE rsi_price=PRICE_CLOSE;//RSI PRICE
input int rsi_buy_level=70;//RSI BUY LEVEL
input int rsi_sell_level=30;//RSI SELL LEVEL
input int rsi_shift=1;//RSI Shift

input string string_ichi="---------------ICHIMOKU---------------";//ICHI MOKU
input bool use_ichi_instant=False;//USE ICHIMOKU INSTANT
input bool use_ichi_switch=False;//USE ICHIMOKU SWITCH
input ENUM_TIMEFRAMES ichi_tf=0;//ICHI TIME FRAME
input int ichi_tenkan_sen=9;//ICHI TENKAN-SEN
input int ichi_kijun_sen=26;//ICHI KIJUN-SEN
input int ichi_senko_span_b=52;//ICHI SENKO SPAN B
input int ichi_shift=1;//ICHI Shift

input string string_sar="---------------SAR---------------";//SAR
input bool use_sar=False;//USE SAR
input ENUM_TIMEFRAMES sar_tf=0;//SAR TIME FRAME
input double sar_step=0.02;//SAR STEP
input double sar_maximum=0.2;//SAR MAXIMUM
input int sar_shift=1;//SAR Shift

input string string_ma="---------------MOVING AVERAGE----------------";//MOVING AVERAGE
input bool use_ma=False;//USE MOVING AVERAGE
input ENUM_TIMEFRAMES ma_tf=0;//MA TIME FRAME
input int ma_period=55;//MA PERIOD
input ENUM_MA_METHOD ma_method=MODE_SMA;//MA METHOD
input ENUM_APPLIED_PRICE ma_apply_to=PRICE_CLOSE;//MA APPLY TO
input int ma_shift=1;//MA Shift

input string string_rvi="---------------RVI----------------";//RVI
input bool use_rvi=False;//USE RVI
input ENUM_TIMEFRAMES rvi_tf=0;//RVI TIME FRAME
input int rvi_period=10;//RVI PERIOD
input int rvi_shift=1;//RVI Shift

input string string_megafxprofit="---------------MEGA FX PROFIT----------------";//MEGA FX PROFIT
input bool use_megafxprofit=False;
input ENUM_TIMEFRAMES megafxprofit_tf=0;//MEGAFX PROFIT TIME FRAME
input int megafxprofit_shift=1;//MEGAFX Shift

input string string_kg="---------------KG SUPPORT RESISTANCE----------------";//KG SUPPORT RESISTANCE
input ENUM_TIMEFRAMES kg_tf=0;//KG S/R TIME FRAME

input string string_risk_target_free="---------------RISK / TARGET FREE----------------";//RISK / TARGET FREE
input enum_cap_rfo do_risk_free_capchannel=cap_nope;//DO RISK FREE CAP CHANNEL
input enum_env_rfo do_risk_free_envelopes=env_nope;//DO RISK FREE ENVELOPES
input enum_twmacd_rfo do_risk_free_twmacd=twmacd_nope;//DO RISK FREE TWMACD
input bool do_risk_free_macd=false;//DO RISK FREE MACD
input bool do_risk_free_ichi=false;//DO RISK FREE ICHI
input bool do_risk_free_sar=false;//DO RISK FREE SAR
input bool do_risk_free_ma=false;//DO RISK FREE MA
input bool do_risk_free_megafxprofit=false;//DO RISK FREE MEGAFXPROFIT
input bool do_risk_free_percent=false;//DO RISK FREE %
input int risk_free_percent=50;//RISK FREE %
input bool do_target_free_percent=false;//DO TARGET FREE %
input int target_free_percent=50;//TARGET FREE %
input int risk_free_space_pips=10;//RISK FREE SPACE PIPS
input int target_free_space_pips=10;//TARGET FREE SPACE PIPS
input int sl_space_pips=10;//SL SPACE PIPS
input string string_trailing_stop="---------------TRAILING STOP----------------";//TRAILING STOP
input bool do_trailing_stop=false;//DO TRAILING STOP
input ENUM_TIMEFRAMES trailing_stop_tf=PERIOD_H1;//TRAILING STOP KGSR TF
input string string_other="---------------OTHER----------------";//OTHER
input bool reset_signal_after_trade=true;//RESET SIGN*AL AFTER TRADE
input int magic=12345;//MAGIC NUMBER
input string comment="PERFECT";//ORDER COMMENT
input bool send_alert=false;//SEND ALERT
input color object_color=clrWhite;//OBJECT COLOR

double kg_s_m15=0;
double kg_r_m15=0;
double kg_s_h1=0;
double kg_r_h1=0;
double kg_s_h4=0;
double kg_r_h4=0;
double kg_s_d1=0;
double kg_r_d1=0;
double capchannel_m=0;
double capchannel_d=0;
double capchannel_u=0;
double envelopes_m=0;
double envelopes_d=0;
double envelopes_u=0;
double macd_main_value_1=0;
double macd_signal_value_1=0;
double macd_main_value_2=0;
double macd_signal_value_2=0;
double twmacd_hist_0=0;
double twmacd_hist_1=0;
double twmacd_hist_2=0;
double sar_0=0;
double sar_1=0;
double ichi_a_0=0;
double ichi_b_0=0;
double ichi_a_1=0;
double ichi_b_1=0;
double rsi=0;
double ma=0;
double rvi_main_value_1=0;
double rvi_signal_value_1=0;
double rvi_main_value_2=0;
double rvi_signal_value_2=0;
double megafxprofit_green=0;
double megafxprofit_red=0;
bool have_sell=false;
bool have_buy=false;
string capchannel_signal="None";
string envelopes_signal="None";
string macd_signal_instant="None";
string macd_signal_switch="None";
string twmacd_signal="None";
string rsi_signal="None";
string ichi_signal_instant="None";
string ichi_signal_switch="None";
string sar_signal="None";
string ma_signal="None";
string megafxprofit_signal="None";
string rvi_signal="None";
double kg_s=0;
double kg_r=0;
double kg_s_trailing_stop=0;
double kg_r_trailing_stop=0;
datetime order_open_time_buy=0;
datetime order_open_time_sell=0;

int martingale_level=0;

int nLastBars=0;
bool NewBar=false;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   kg_r_m15=iCustom(Symbol(),Period(),"KG_Support_and_Resistance",0,0);
   kg_s_m15=iCustom(Symbol(),Period(),"KG_Support_and_Resistance",1,0);

   kg_r_h1=iCustom(Symbol(),Period(),"KG_Support_and_Resistance",2,0);
   kg_s_h1=iCustom(Symbol(),Period(),"KG_Support_and_Resistance",3,0);

   kg_r_h4=iCustom(Symbol(),Period(),"KG_Support_and_Resistance",4,0);
   kg_s_h4=iCustom(Symbol(),Period(),"KG_Support_and_Resistance",5,0);

   kg_r_d1=iCustom(Symbol(),Period(),"KG_Support_and_Resistance",6,0);
   kg_s_d1=iCustom(Symbol(),Period(),"KG_Support_and_Resistance",7,0);


   if(kg_tf==PERIOD_D1 || (Period()==PERIOD_D1 && kg_tf==0))
     {
      kg_s=kg_s_d1;
      kg_r=kg_r_d1;
     }

   if(kg_tf==PERIOD_H4 || (Period()==PERIOD_H4 && kg_tf==0))
     {
      kg_s=kg_s_h4;
      kg_r=kg_r_h4;
     }

   if(kg_tf==PERIOD_H1 || (Period()==PERIOD_H1 && kg_tf==0))
     {
      kg_s=kg_s_h1;
      kg_r=kg_r_h1;
     }

   if(kg_tf==PERIOD_M15 || (Period()==PERIOD_M15 && kg_tf==0))
     {
      kg_s=kg_s_m15;
      kg_r=kg_r_m15;
     }

   if(trailing_stop_tf==PERIOD_D1 || (Period()==PERIOD_D1 && trailing_stop_tf==0))
     {
      kg_s_trailing_stop=kg_s_d1;
      kg_r_trailing_stop=kg_r_d1;
     }
     
   if(trailing_stop_tf==PERIOD_H4 || (Period()==PERIOD_H4 && trailing_stop_tf==0))
     {
      kg_s_trailing_stop=kg_s_h4;
      kg_r_trailing_stop=kg_r_h4;
     }
     
   if(trailing_stop_tf==PERIOD_H1 || (Period()==PERIOD_H1 && trailing_stop_tf==0))
     {
      kg_s_trailing_stop=kg_s_h1;
      kg_r_trailing_stop=kg_r_h1;
     }
     
   if(trailing_stop_tf==PERIOD_M15 || (Period()==PERIOD_M15 && trailing_stop_tf==0))
     {
      kg_s_trailing_stop=kg_s_m15;
      kg_r_trailing_stop=kg_r_m15;
     }               

   
   capchannel_m=iCustom(Symbol(),capchannel_tf,"OMID CAP CHANNEL 1.0",
                        capchannel_tf,
                        capchannel_half_length,
                        capchannel_price,
                        capchannel_bands_deviation,false,false,false,false,false,false,false,0,capchannel_shift);

   capchannel_u=iCustom(Symbol(),capchannel_tf,"OMID CAP CHANNEL 1.0",
                        capchannel_tf,
                        capchannel_half_length,
                        capchannel_price,
                        capchannel_bands_deviation,false,false,false,false,false,false,false,1,capchannel_shift);

   capchannel_d=iCustom(Symbol(),capchannel_tf,"OMID CAP CHANNEL 1.0",
                        capchannel_tf,
                        capchannel_half_length,
                        capchannel_price,
                        capchannel_bands_deviation,false,false,false,false,false,false,false,2,capchannel_shift);

   envelopes_m=iEnvelopes(Symbol(),envelopes_tf,envelopes_ma_period,envelopes_ma_method,envelopes_ma_shift,
                          envelopes_applied_price,envelopes_deviation,MODE_MAIN,env_shift);

   envelopes_u=iEnvelopes(Symbol(),envelopes_tf,envelopes_ma_period,envelopes_ma_method,envelopes_ma_shift,
                          envelopes_applied_price,envelopes_deviation,MODE_UPPER,env_shift);

   envelopes_d=iEnvelopes(Symbol(),envelopes_tf,envelopes_ma_period,envelopes_ma_method,envelopes_ma_shift,
                          envelopes_applied_price,envelopes_deviation,MODE_LOWER,env_shift);

   macd_main_value_1=iMACD(Symbol(),macd_tf,macd_fast_ma,macd_slow_ma,macd_signal_ma,PRICE_CLOSE,MODE_MAIN,macd_shift);
   macd_signal_value_1=iMACD(Symbol(),macd_tf,macd_fast_ma,macd_slow_ma,macd_signal_ma,PRICE_CLOSE,MODE_SIGNAL,macd_shift);
   macd_main_value_2=iMACD(Symbol(),macd_tf,macd_fast_ma,macd_slow_ma,macd_signal_ma,PRICE_CLOSE,MODE_MAIN,macd_shift+1);
   macd_signal_value_2=iMACD(Symbol(),macd_tf,macd_fast_ma,macd_slow_ma,macd_signal_ma,PRICE_CLOSE,MODE_SIGNAL,macd_shift+1);
      
   twmacd_hist_0 = iCustom(Symbol(),twmacd_tf,"Trading_View_MACD_1",
                            twmacd_fast_ma,macd_slow_ma,twmacd_signal_ma,twmacd_osc_method,twmacd_signal_method,twmacd_applied_price,2,0);
   twmacd_hist_1 = iCustom(Symbol(),twmacd_tf,"Trading_View_MACD_1",
                            twmacd_fast_ma,macd_slow_ma,twmacd_signal_ma,twmacd_osc_method,twmacd_signal_method,twmacd_applied_price,2,twmacd_shift);
   twmacd_hist_2 = iCustom(Symbol(),twmacd_tf,"Trading_View_MACD_1",
                            twmacd_fast_ma,macd_slow_ma,twmacd_signal_ma,twmacd_osc_method,twmacd_signal_method,twmacd_applied_price,2,twmacd_shift+1);  
                          
   rsi=iRSI(Symbol(),rsi_tf,rsi_period,rsi_price,rsi_shift);

   sar_0=iSAR(Symbol(),sar_tf,sar_step,sar_maximum,rsi_shift);
   sar_1=iSAR(Symbol(),sar_tf,sar_step,sar_maximum,rsi_shift);

   ichi_a_0=iIchimoku(Symbol(),ichi_tf,ichi_tenkan_sen,ichi_kijun_sen,ichi_senko_span_b,MODE_SENKOUSPANA,ichi_shift);
   ichi_b_0=iIchimoku(Symbol(),ichi_tf,ichi_tenkan_sen,ichi_kijun_sen,ichi_senko_span_b,MODE_SENKOUSPANB,ichi_shift);

   ichi_a_1=iIchimoku(Symbol(),ichi_tf,ichi_tenkan_sen,ichi_kijun_sen,ichi_senko_span_b,MODE_SENKOUSPANA,ichi_shift+1);
   ichi_b_1=iIchimoku(Symbol(),ichi_tf,ichi_tenkan_sen,ichi_kijun_sen,ichi_senko_span_b,MODE_SENKOUSPANB,ichi_shift+1);
   
   ma=iMA(Symbol(),ma_tf,ma_period,0,ma_method,ma_apply_to,ma_shift);
   
   rvi_main_value_1=iRVI(Symbol(),rvi_tf,rvi_period,MODE_MAIN,rvi_shift);
   rvi_signal_value_1=iRVI(Symbol(),rvi_tf,rvi_period,MODE_SIGNAL,rvi_shift);
   rvi_main_value_2=iRVI(Symbol(),rvi_tf,rvi_period,MODE_MAIN,rvi_shift+1);
   rvi_signal_value_2=iRVI(Symbol(),rvi_tf,rvi_period,MODE_SIGNAL,rvi_shift+1);
      
   megafxprofit_green=iCustom(Symbol(),megafxprofit_tf,"mega-fx-profit-indicator",false,false,"alert.wave",false,1,megafxprofit_shift);
   megafxprofit_red=iCustom(Symbol(),megafxprofit_tf,"mega-fx-profit-indicator",false,false,"alert.wave",false,2,megafxprofit_shift);
   
   int y_of_lable=35;
   OBJECT_LABEL(comment+"dotrade",ANCHOR_LEFT,CORNER_LEFT_UPPER,5,y_of_lable,"Do Trade : "+do_trade_input,8,object_color,"Arial Bold");
   y_of_lable=y_of_lable+20;
   
   string indi_used="";
   if(use_capchannel)
      indi_used+="CAP,";
   if(use_envelopes)
      indi_used+="ENV,";
   if(use_ichi_instant || use_ichi_switch)
      indi_used+="ICHI,";
   if(use_ma)
      indi_used+="MA,";
   if(use_macd_instant || use_macd_switch)
      indi_used+="MACD,";
   if(use_twmacd)
      indi_used+="TW MACD,";      
   if(use_megafxprofit)
      indi_used+="MFXP,";
   if(use_rsi)
      indi_used+="RSI,";
   if(use_sar)
      indi_used+="SAR,";
   if(use_rvi)
      indi_used+="RVI,";     
       
   OBJECT_LABEL(comment+"indi_used",ANCHOR_LEFT,CORNER_LEFT_UPPER,5,y_of_lable,indi_used,8,object_color,"Arial Bold");
   y_of_lable=y_of_lable+20;
   
   string martingale_text="";
   if(lot_control_input==fixed_risk)
      martingale_text+="FIX RISK "+DoubleToStr(risk_input,1)+" %";
   if(lot_control_input==positive_martingale)
      martingale_text+="POSITIVE MARTINGALE "+DoubleToStr(risk_input,1)+" %"+"   "+"MARTI LEVEL : +"+IntegerToString(martingale_level);
   if(lot_control_input==negative_martingale)
      martingale_text+="NEGATIVE MARTINGALE "+DoubleToStr(risk_input,1)+" %"+"   "+"MARTI LEVEL : -"+IntegerToString(martingale_level);
   OBJECT_LABEL(comment+"marti",ANCHOR_LEFT,CORNER_LEFT_UPPER,5,y_of_lable,martingale_text,8,object_color,"Arial Bold");
   y_of_lable=y_of_lable+20;
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   ObjectsDeleteAll(0,comment);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   int nBars=iBars(Symbol(),trigger_tf_input);
   if(nLastBars!=nBars)
     {
      nLastBars=nBars;
      NewBar=true;
     }
   else
     {
      NewBar=false;
     }
   if(iVolume(Symbol(),trigger_tf_input,0)<=1)
     {
      //Print("NewBar");
     }
//if (iVolume(Symbol(),trigger_tf_input,0)<=1)
//if (NewBar)
   if(Volume[0]<=1)
     {
      //Print(iVolume(Symbol(),trigger_tf_input,0));
      //Print("CHECK FOR TRADE!");
     }
//if (iVolume(Symbol(),trigger_tf_input,0)<=1 && NewBar)
//if (NewBar)
   if(Volume[0]<=1)
     {
      kg_r_m15=iCustom(Symbol(),Period(),"KG_Support_and_Resistance",0,0);
      kg_s_m15=iCustom(Symbol(),Period(),"KG_Support_and_Resistance",1,0);

      kg_r_h1=iCustom(Symbol(),Period(),"KG_Support_and_Resistance",2,0);
      kg_s_h1=iCustom(Symbol(),Period(),"KG_Support_and_Resistance",3,0);

      kg_r_h4=iCustom(Symbol(),Period(),"KG_Support_and_Resistance",4,0);
      kg_s_h4=iCustom(Symbol(),Period(),"KG_Support_and_Resistance",5,0);
      
      kg_r_d1=iCustom(Symbol(),Period(),"KG_Support_and_Resistance",6,0);
      kg_s_d1=iCustom(Symbol(),Period(),"KG_Support_and_Resistance",7,0);

      if(kg_tf==PERIOD_D1 || (Period()==PERIOD_D1 && kg_tf==0))
        {
         kg_s=kg_s_d1;
         kg_r=kg_r_d1;
        }

      if(kg_tf==PERIOD_H4 || (Period()==PERIOD_H4 && kg_tf==0))
        {
         kg_s=kg_s_h4;
         kg_r=kg_r_h4;
        }

      if(kg_tf==PERIOD_H1 || (Period()==PERIOD_H1 && kg_tf==0))
        {
         kg_s=kg_s_h1;
         kg_r=kg_r_h1;
        }

      if(kg_tf==PERIOD_M15 || (Period()==PERIOD_M15 && kg_tf==0))
        {
         kg_s=kg_s_m15;
         kg_r=kg_r_m15;
        }

   if(trailing_stop_tf==PERIOD_D1 || (Period()==PERIOD_D1 && trailing_stop_tf==0))
     {
      kg_s_trailing_stop=kg_s_d1;
      kg_r_trailing_stop=kg_r_d1;
     }
     
   if(trailing_stop_tf==PERIOD_H4 || (Period()==PERIOD_H4 && trailing_stop_tf==0))
     {
      kg_s_trailing_stop=kg_s_h4;
      kg_r_trailing_stop=kg_r_h4;
     }
     
   if(trailing_stop_tf==PERIOD_H1 || (Period()==PERIOD_H1 && trailing_stop_tf==0))
     {
      kg_s_trailing_stop=kg_s_h1;
      kg_r_trailing_stop=kg_r_h1;
     }
     
   if(trailing_stop_tf==PERIOD_M15 || (Period()==PERIOD_M15 && trailing_stop_tf==0))
     {
      kg_s_trailing_stop=kg_s_m15;
      kg_r_trailing_stop=kg_r_m15;
     }
     
      capchannel_m=iCustom(Symbol(),capchannel_tf,"OMID CAP CHANNEL 1.0",
                           capchannel_tf,
                           capchannel_half_length,
                           capchannel_price,
                           capchannel_bands_deviation,false,false,false,false,false,false,false,0,capchannel_shift);

      capchannel_u=iCustom(Symbol(),capchannel_tf,"OMID CAP CHANNEL 1.0",
                           capchannel_tf,
                           capchannel_half_length,
                           capchannel_price,
                           capchannel_bands_deviation,false,false,false,false,false,false,false,1,capchannel_shift);

      capchannel_d=iCustom(Symbol(),capchannel_tf,"OMID CAP CHANNEL 1.0",
                           capchannel_tf,
                           capchannel_half_length,
                           capchannel_price,
                           capchannel_bands_deviation,false,false,false,false,false,false,false,2,capchannel_shift);
      //capchannel_signal="None";
      if(Bid<capchannel_d)
        {
         capchannel_signal="buy";
        }
      if(iLow(Symbol(),trigger_tf_input,1)<capchannel_d)
        {
         capchannel_signal="buy";
        }
      if(Low[1]<capchannel_d)
        {
         capchannel_signal="buy";
        }
      if(Bid>capchannel_u)
        {
         capchannel_signal="sell";
        }
      if(iHigh(Symbol(),trigger_tf_input,1)>capchannel_u)
        {
         capchannel_signal="sell";
        }
      if(High[1]>capchannel_u)
        {
         capchannel_signal="sell";
        }
      if(Bid<capchannel_m && capchannel_signal=="sell")
        {
         capchannel_signal="None";
        }
      if(Bid>capchannel_m && capchannel_signal=="buy")
        {
         capchannel_signal="None";
        }

      envelopes_m=iEnvelopes(Symbol(),envelopes_tf,envelopes_ma_period,envelopes_ma_method,envelopes_ma_shift,
                             envelopes_applied_price,envelopes_deviation,MODE_MAIN,env_shift);

      envelopes_u=iEnvelopes(Symbol(),envelopes_tf,envelopes_ma_period,envelopes_ma_method,envelopes_ma_shift,
                             envelopes_applied_price,envelopes_deviation,MODE_UPPER,env_shift);

      envelopes_d=iEnvelopes(Symbol(),envelopes_tf,envelopes_ma_period,envelopes_ma_method,envelopes_ma_shift,
                             envelopes_applied_price,envelopes_deviation,MODE_LOWER,env_shift);

      if(Bid<envelopes_d)
         envelopes_signal="buy";
      if(Ask>envelopes_u)
         envelopes_signal="sell";
      if(Ask>envelopes_m && envelopes_signal=="buy")
         envelopes_signal="None";
      if(Bid<envelopes_m && envelopes_signal=="sell")
         envelopes_signal="None";

      macd_main_value_1=iMACD(Symbol(),macd_tf,macd_fast_ma,macd_slow_ma,macd_signal_ma,PRICE_CLOSE,MODE_MAIN,macd_shift);
      macd_signal_value_1=iMACD(Symbol(),macd_tf,macd_fast_ma,macd_slow_ma,macd_signal_ma,PRICE_CLOSE,MODE_SIGNAL,macd_shift);
      macd_main_value_2=iMACD(Symbol(),macd_tf,macd_fast_ma,macd_slow_ma,macd_signal_ma,PRICE_CLOSE,MODE_MAIN,macd_shift+1);
      macd_signal_value_2=iMACD(Symbol(),macd_tf,macd_fast_ma,macd_slow_ma,macd_signal_ma,PRICE_CLOSE,MODE_SIGNAL,macd_shift+1);
      
      macd_signal_switch="None";
      if(macd_main_value_1>macd_signal_value_1 && macd_main_value_2<macd_signal_value_2)
         macd_signal_switch="buy";
      if(macd_main_value_1<macd_signal_value_1 && macd_main_value_2>macd_signal_value_2)
         macd_signal_switch="sell";
         
      macd_signal_instant="None";
      if(macd_main_value_1>macd_signal_value_1)
         macd_signal_instant="buy";
      if(macd_main_value_1<macd_signal_value_1)
         macd_signal_instant="sell";
                  
      rvi_main_value_1=iRVI(Symbol(),rvi_tf,rvi_period,MODE_MAIN,rvi_shift);
      rvi_signal_value_1=iRVI(Symbol(),rvi_tf,rvi_period,MODE_SIGNAL,rvi_shift); 
      rvi_main_value_2=iRVI(Symbol(),rvi_tf,rvi_period,MODE_MAIN,rvi_shift+1);
      rvi_signal_value_2=iRVI(Symbol(),rvi_tf,rvi_period,MODE_SIGNAL,rvi_shift+1); 
         
      rvi_signal="None";
      if(rvi_main_value_1<rvi_signal_value_1 && rvi_main_value_2>rvi_signal_value_2) rvi_signal="sell";
      if(rvi_main_value_1>rvi_signal_value_1 && rvi_main_value_2<rvi_signal_value_2) rvi_signal="buy";
      
      twmacd_hist_0 = iCustom(Symbol(),twmacd_tf,"Trading_View_MACD_1",
                              twmacd_fast_ma,macd_slow_ma,twmacd_signal_ma,twmacd_osc_method,twmacd_signal_method,twmacd_applied_price,2,0);
      twmacd_hist_1 = iCustom(Symbol(),twmacd_tf,"Trading_View_MACD_1",
                              twmacd_fast_ma,macd_slow_ma,twmacd_signal_ma,twmacd_osc_method,twmacd_signal_method,twmacd_applied_price,2,twmacd_shift);
      twmacd_hist_2 = iCustom(Symbol(),twmacd_tf,"Trading_View_MACD_1",
                              twmacd_fast_ma,macd_slow_ma,twmacd_signal_ma,twmacd_osc_method,twmacd_signal_method,twmacd_applied_price,2,twmacd_shift+1); 
      twmacd_signal="None";
      if (twmacd_hist_1>0 && twmacd_hist_2<0) twmacd_signal="buy";    
      if (twmacd_hist_1<0 && twmacd_hist_2>0) twmacd_signal="sell"; 
                                  
      rsi_signal="None";
      rsi=iRSI(Symbol(),rsi_tf,rsi_period,rsi_price,rsi_shift);
      if(rsi>50 && rsi<=rsi_buy_level)
         rsi_signal="buy";
      if(rsi<50 && rsi>=rsi_sell_level)
         rsi_signal="sell";

      sar_0=iSAR(Symbol(),sar_tf,sar_step,sar_maximum,sar_shift);
      sar_1=iSAR(Symbol(),sar_tf,sar_step,sar_maximum,sar_shift+1);
      sar_signal="None";
      if(Close[1]>sar_0 && sar_0<sar_1)
        {
         sar_signal="buy";
        }
      if(Close[1]<sar_0 && sar_0>sar_1)
        {
         sar_signal="sell";
        }
      //Comment("\n","\n","\n","\n","\n",sar_signal,"\n",sar_0,"\n",Close[1]);
      
      ichi_a_0=iIchimoku(Symbol(),ichi_tf,ichi_tenkan_sen,ichi_kijun_sen,ichi_senko_span_b,MODE_SENKOUSPANA,ichi_shift);
      ichi_b_0=iIchimoku(Symbol(),ichi_tf,ichi_tenkan_sen,ichi_kijun_sen,ichi_senko_span_b,MODE_SENKOUSPANB,ichi_shift);
      ichi_a_1=iIchimoku(Symbol(),ichi_tf,ichi_tenkan_sen,ichi_kijun_sen,ichi_senko_span_b,MODE_SENKOUSPANA,ichi_shift+1);
      ichi_b_1=iIchimoku(Symbol(),ichi_tf,ichi_tenkan_sen,ichi_kijun_sen,ichi_senko_span_b,MODE_SENKOUSPANB,ichi_shift+1);
      ichi_signal_instant="None";
      if(Bid>ichi_a_0 && Bid>ichi_b_0)
        {
         ichi_signal_instant="buy";
        }
      if(Ask<ichi_a_0 && Ask<ichi_b_0)
        {
         ichi_signal_instant="sell";
        }
        
      if(Close[1]>ichi_a_0 && Close[1]>ichi_b_0 && (Close[2]<ichi_a_1 || Close[2]<ichi_b_1))
        {
         ichi_signal_switch="buy";
        }
      if(Close[1]<ichi_a_0 && Close[1]<ichi_b_0 && (Close[2]>ichi_a_1 || Close[2]>ichi_b_1))
        {
         ichi_signal_switch="sell";
        }        

      ma=iMA(Symbol(),ma_tf,ma_period,0,ma_method,ma_apply_to,ma_shift);
      ma_signal="None";
      if(use_capchannel && Bid>ma)
        {
         ma_signal="buy";
        }
      if(use_capchannel && Ask<ma)
        {
         ma_signal="sell";
        }

      if(!use_capchannel && Ask<capchannel_m && Bid>ma)
        {
         ma_signal="buy";
        }
      if(!use_capchannel && Bid>capchannel_m && Ask<ma)
        {
         ma_signal="sell";
        }

      megafxprofit_green=iCustom(Symbol(),megafxprofit_tf,"mega-fx-profit-indicator",false,false,"alert.wave",false,1,megafxprofit_shift);
      megafxprofit_red=iCustom(Symbol(),megafxprofit_tf,"mega-fx-profit-indicator",false,false,"alert.wave",false,2,megafxprofit_shift);

      megafxprofit_signal="None";
      if(megafxprofit_green>0 && megafxprofit_red==0)
        {
         megafxprofit_signal="buy";
        }
      if(megafxprofit_green==0 && megafxprofit_red<0)
        {
         megafxprofit_signal="sell";
        }
      /*
      Comment("\n","\n",
              "Do Trade : ",do_trade_input,"\n",
              "Risk :",risk,"%","\n",
              "CAP SIGNAL : ",capchannel_signal,"   ",use_capchannel,"\n",
              "ENV SIGNAL : ",envelopes_signal,"   ",use_envelopes,"\n",
              "MACD SIGNAL : ",macd_signal,"   ",use_macd,"\n",
              "RSI SIGNAL : ",rsi_signal,"   ",use_rsi,"\n",
              "ICHI SIGNAL :",ichi_signal,"   ",use_ichi,"\n",
              "SAR SIGNAL :",sar_signal,"   ",use_sar,"\n",
              "MA SIGNAL :",ma_signal,"   ",use_ma,"\n",
              "MFXP SIGNAL :",megafxprofit_signal,"   ",use_megafxprofit,"\n",
              "Alert : ",send_alert);
      */
      //Comment(envelopes_signal);
     }
//if (iVolume(Symbol(),trigger_tf_input,0)<=1)
//if (NewBar)
   if(closing_options==close_by_opposit)
     {
      for(int cnt=0; cnt<OrdersTotal(); cnt++)
        {
         if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
            continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic && OrderType()==OP_BUY)
           {
            if(OrderOpenTime()<order_open_time_sell && have_sell)
              {
               Print("PERFECT IS CLOSING BUY ORDER.");
               int bc=OrderClose(OrderTicket(),OrderLots(),Bid,0,clrRed);
               if(bc>0)
                 {
                  Print("PERFECT CLOSED BUY ORDER FOR NEW SELL ORDER.");
                 }
              }
           }
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic && OrderType()==OP_SELL)
           {
            if(OrderOpenTime()<order_open_time_buy && have_buy)
              {
               Print("PERFECT IS CLOSING SELL ORDER.");
               int sc=OrderClose(OrderTicket(),OrderLots(),Ask,0,clrBlue);
               if(sc>0)
                 {
                  Print("PERFECT CLOSED SELL ORDER FOR NEW BUY ORDER.");
                 }
              }
           }
        }
     }
   if(Volume[0]<=1)
     {
      have_buy=false;
      have_sell=false;
      order_open_time_buy=0;
      order_open_time_sell=0;
      for(int cnt=0; cnt<OrdersTotal(); cnt++)
        {
         if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
            continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic && OrderType()==OP_BUY)
           {
            have_buy=true;
            order_open_time_buy=OrderOpenTime();
            if(capchannel_signal=="buy")
               capchannel_signal="None";
           }
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic && OrderType()==OP_SELL)
           {
            have_sell=true;
            order_open_time_sell=OrderOpenTime();
            if(capchannel_signal=="sell")
               capchannel_signal="None";
           }
        }
      if (do_multipletrade)
         {
         have_buy=false;
         have_sell=false;
         }
      if(1<0 && closing_options==close_by_opposit)
        {
         for(int cnt=0; cnt<OrdersTotal(); cnt++)
           {
            if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
               continue;
            if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic && OrderType()==OP_BUY)
              {
               if(OrderOpenTime()<order_open_time_sell && have_sell)
                 {
                  Print("PERFECT IS CLOSING BUY ORDER.");
                  int bc=OrderClose(OrderTicket(),OrderLots(),Bid,0,clrRed);
                  if(bc>0)
                    {
                     Print("PERFECT CLOSED BUY ORDER.");
                    }
                 }
              }
            if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic && OrderType()==OP_SELL)
              {
               if(OrderOpenTime()<order_open_time_buy && have_buy)
                 {
                  Print("PERFECT IS CLOSING SELL ORDER.");
                  int sc=OrderClose(OrderTicket(),OrderLots(),Ask,0,clrBlue);
                  if(sc>0)
                    {
                     Print("PERFECT CLOSED SELL ORDER.");
                    }
                 }
              }
           }
        }

      if(closing_options==close_by_capchannel)
        {
         for(int cnt=0; cnt<OrdersTotal(); cnt++)
           {
            if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
               continue;
            if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic && OrderType()==OP_BUY)
              {
               if(Bid>=capchannel_u)
                 {
                  Print("PERFECT IS CLOSING BUY ORDER.");
                  int bc=OrderClose(OrderTicket(),OrderLots(),Bid,0,clrRed);
                  if(bc>0)
                    {
                     Print("PERFECT CLOSED BUY ORDER.");
                    }
                 }
              }
            if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic && OrderType()==OP_SELL)
              {
               if(Ask<=capchannel_d)
                 {
                  Print("PERFECT IS CLOSING SELL ORDER.");
                  int sc=OrderClose(OrderTicket(),OrderLots(),Ask,0,clrBlue);
                  if(sc>0)
                    {
                     Print("PERFECT CLOSED SELL ORDER.");
                    }
                 }
              }
           }
        }
      if(closing_options==close_by_envelopes)
        {
         for(int cnt=0; cnt<OrdersTotal(); cnt++)
           {
            if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
               continue;
            if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic && OrderType()==OP_BUY)
              {
               if(Bid>=envelopes_u)
                 {
                  Print("PERFECT IS CLOSING BUY ORDER.");
                  int bc=OrderClose(OrderTicket(),OrderLots(),Bid,0,clrRed);
                  if(bc>0)
                    {
                     Print("PERFECT CLOSED BUY ORDER.");
                    }
                 }
              }
            if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic && OrderType()==OP_SELL)
              {
               if(Ask<=envelopes_d)
                 {
                  Print("PERFECT IS CLOSING SELL ORDER.");
                  int sc=OrderClose(OrderTicket(),OrderLots(),Ask,0,clrBlue);
                  if(sc>0)
                    {
                     Print("PERFECT CLOSED SELL ORDER.");
                    }
                 }
              }
           }
        }
      for(int cnt=0; cnt<OrdersHistoryTotal(); cnt++)
        {
         if(!OrderSelect(OrdersHistoryTotal()-cnt, SELECT_BY_POS,MODE_HISTORY))
            continue;
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic)
           {
            martingale_level=StringToInteger(StringSubstr(OrderComment(),StringLen(comment),StringLen(OrderComment())-StringLen(comment)));
            //Print(martingale_level);
            if(lot_control_input==fixed_risk)
               martingale_level=0;

            if(lot_control_input==negative_martingale && OrderProfit()>0)
               martingale_level=0;
            if(lot_control_input==negative_martingale && OrderProfit()<0)
               martingale_level=martingale_level+1;

            if(lot_control_input==positive_martingale && OrderProfit()<0)
               martingale_level=0;
            if(lot_control_input==positive_martingale && OrderProfit()>0)
               martingale_level=martingale_level+1;

            if(martingale_level>martingale_max_level)
               martingale_level=0;
            break;
           }
        }
     }
   if( //iVolume(Symbol(),trigger_tf_input,0)<=1 &&
//NewBar &&
      Volume[0]<=1 &&
      !have_buy &&
      ((use_capchannel && capchannel_signal=="buy" && iClose(Symbol(),trigger_tf_input,1)>capchannel_d && iClose(Symbol(),trigger_tf_input,1)<capchannel_m) || !use_capchannel) &&
      ((use_envelopes  && envelopes_signal=="buy"  && iClose(Symbol(),trigger_tf_input,1)>envelopes_d  && iClose(Symbol(),trigger_tf_input,1)<envelopes_m)  || !use_envelopes) &&
      ((use_macd_instant && macd_signal_instant=="buy") || !use_macd_instant) &&
      ((use_macd_switch && macd_signal_switch=="buy") || !use_macd_switch) &&      
      ((use_twmacd && twmacd_signal=="buy") || !use_twmacd) &&      
      ((use_rsi && rsi_signal=="buy") || !use_rsi) &&
      ((use_sar && iClose(Symbol(),trigger_tf_input,1)>sar_0) || !use_sar) &&
//((use_ma && iClose(Symbol(),trigger_tf_input,1)>ma) || !use_ma) &&
      ((use_ma && ma_signal=="buy") || !use_ma) &&
      ((use_rvi && rvi_signal=="buy") || !use_rvi) &&
      ((use_ichi_instant && ichi_signal_instant=="buy") || !use_ichi_instant) &&
      ((use_ichi_switch && ichi_signal_switch=="buy") || !use_ichi_switch) &&
      ((use_megafxprofit && megafxprofit_green>0 && megafxprofit_red==0) || !use_megafxprofit) &&
      iClose(Symbol(),trigger_tf_input,1)>kg_s)
     {
      double pip_value=NormalizeDouble((MarketInfo(Symbol(),MODE_TICKVALUE)*Point)/MarketInfo(Symbol(),MODE_TICKSIZE),2);
      double lot_size=MarketInfo(Symbol(),MODE_MINLOT);
      double stop_usd=0;
      if(risk_equity_selector==account_equity)
         stop_usd=risk_input*AccountEquity()/100;
      if(risk_equity_selector==account_balance)
         stop_usd=risk_input*AccountBalance()/100;
      if(risk_equity_selector==fixed_balance)
         stop_usd=risk_input*fixed_balance_usd/100;
      if(stop_usd==0)
         stop_usd=1;
      
      double sl=0;
      if (stop_calculator_input==sl_kgsr_calculator)
         { 
         sl=kg_s;
         double sl_temp=sl;
         for(int counter=0; counter<=20; counter++)
           {
            sl_temp=MathMin(sl_temp,Low[counter]);
           }
         sl=MathMin(sl,sl_temp);
         if (use_capchannel) sl=MathMin(sl,capchannel_d);
         if (use_envelopes) sl=MathMin(sl,envelopes_d);
         if(min_stop_pips>0) sl=MathMin(sl,Ask-min_stop_pips*Point);
         sl = sl - sl_space_pips*Point;
         }
      if (stop_calculator_input==sl_manual)
         {
         sl = Ask - (manual_stop_pips_input * Point);
         if (manual_stop_pips_input==0) sl = 0;
         }
      
      if (sl!=0)
      {
      if(Digits==5)
         lot_size= NormalizeDouble(stop_usd/(100000*pip_value*(iClose(Symbol(),trigger_tf_input,1)-sl)),2);
      if(Digits==4)
         lot_size= NormalizeDouble(stop_usd/(10000*pip_value*(iClose(Symbol(),trigger_tf_input,1)-sl)),2);
      if(Digits==3)
         lot_size= NormalizeDouble(stop_usd/(1000*pip_value*(iClose(Symbol(),trigger_tf_input,1)-sl)),2);
      if(Digits==2)
         lot_size= NormalizeDouble(stop_usd/(100*pip_value*(iClose(Symbol(),trigger_tf_input,1)-sl)),2);
      if(Digits==1)
         lot_size= NormalizeDouble(stop_usd/(10*pip_value*(iClose(Symbol(),trigger_tf_input,1)-sl)),2);
      if(Digits==0)
         lot_size= NormalizeDouble(stop_usd/(1*pip_value*(iClose(Symbol(),trigger_tf_input,1)-sl)),2);
         
      lot_size = lot_size * MathPow(2 , martingale_level);
      }
      
      if (lot_control_input==fixed_lot) lot_size=fixed_lot_input;
      
      if(lot_size<MarketInfo(Symbol(),MODE_MINLOT))
         lot_size=MarketInfo(Symbol(),MODE_MINLOT);
      if(lot_size>MarketInfo(Symbol(),MODE_MAXLOT))
         lot_size=MarketInfo(Symbol(),MODE_MAXLOT);


      if(do_trade_input && closing_options==fix_tp)
        {
         double tp=MathMax(Ask+(iClose(Symbol(),trigger_tf_input,1)-kg_s),capchannel_m);
         tp=MathMax(Ask+(Ask-sl)*fix_tp_risk_reward_ratio,tp);
         if (do_trailing_stop) tp=0;
         
         Print("PERFECT IS SENDING BUY ORDER.");
         Print("ASK: ",Ask," | LOT: ",lot_size," | TP: ",tp," | SL: ",sl);

         int bs=OrderSend(Symbol(),OP_BUY,lot_size,Ask,0,sl,tp,comment+IntegerToString(martingale_level),magic,0,clrBlue);
         if(bs>0)
           {
            if (reset_signal_after_trade) SIGNAL_RESET();
            Print("PERFECT ORDER BUY SENT.");
           }
        }

      if(do_trade_input && closing_options==close_by_capchannel)
        {
         double tp=MathMax(Ask+(iClose(Symbol(),trigger_tf_input,1)-kg_s),capchannel_u);
         tp=MathMax(Ask+(Ask-sl),tp);
         if (do_trailing_stop) tp=0;
         
         Print("PERFECT IS SENDING BUY ORDER.");
         Print("ASK: ",Ask," | LOT: ",lot_size," | TP: ",tp," | SL: ",sl);

         int bs=OrderSend(Symbol(),OP_BUY,lot_size,Ask,0,sl,tp,comment+IntegerToString(martingale_level),magic,0,clrBlue);
         if(bs>0)
           {
            if (reset_signal_after_trade) SIGNAL_RESET();
            Print("PERFECT ORDER BUY SENT.");
           }
        }

      if(do_trade_input && closing_options==close_by_opposit)
        {
         Print("PERFECT IS SENDING BUY ORDER.");
         Print("ASK: ",Ask," | LOT: ",lot_size," | TP: ","0"," | SL: ",sl);

         int bs=OrderSend(Symbol(),OP_BUY,lot_size,Ask,0,sl,0,comment+IntegerToString(martingale_level),magic,0,clrBlue);
         if(bs>0)
           {
            if (reset_signal_after_trade) SIGNAL_RESET();
            Print("PERFECT ORDER BUY SENT.");
           }
        }
      if(send_alert)
        {
         Alert(Symbol(),"   ",capchannel_tf,"   BUY!");
        }
     }
   if( //iVolume(Symbol(),trigger_tf_input,0)<=1 &&
//NewBar &&
      Volume[0]<=1 &&
      !have_sell &&
      ((use_capchannel && capchannel_signal=="sell" && iClose(Symbol(),trigger_tf_input,1)<capchannel_u && iClose(Symbol(),trigger_tf_input,1)>capchannel_m) || !use_capchannel) &&
      ((use_envelopes && envelopes_signal=="sell"  && iClose(Symbol(),trigger_tf_input,1)<envelopes_u  && iClose(Symbol(),trigger_tf_input,1)>envelopes_m)  || !use_envelopes) &&
      ((use_macd_instant && macd_signal_instant=="sell") || !use_macd_instant) &&
      ((use_macd_switch && macd_signal_switch=="sell") || !use_macd_switch) &&      
      ((use_twmacd && twmacd_signal=="sell") || !use_twmacd) &&      
      ((use_rsi && rsi_signal=="sell") || !use_rsi) &&
      ((use_sar && iClose(Symbol(),trigger_tf_input,1)<sar_0) || !use_sar) &&
//((use_ma && iClose(Symbol(),trigger_tf_input,1)<ma) || !use_ma) &&
      ((use_ma && ma_signal=="sell") || !use_ma) &&
      ((use_rvi && rvi_signal=="sell") || !use_rvi) &&
      ((use_ichi_instant && ichi_signal_instant=="sell") || !use_ichi_instant) &&
      ((use_ichi_switch && ichi_signal_switch=="sell") || !use_ichi_switch) &&
      ((use_megafxprofit && megafxprofit_green==0 && megafxprofit_red<0) || !use_megafxprofit) &&
      iClose(Symbol(),trigger_tf_input,1)<kg_r)
     {
      double pip_value=NormalizeDouble((MarketInfo(Symbol(),MODE_TICKVALUE)*Point)/MarketInfo(Symbol(),MODE_TICKSIZE),2);
      double lot_size=MarketInfo(Symbol(),MODE_MINLOT);
      double stop_usd=0;
      if(risk_equity_selector==account_equity)
         stop_usd=risk_input*AccountEquity()/100;
      if(risk_equity_selector==account_balance)
         stop_usd=risk_input*AccountBalance()/100;
      if(risk_equity_selector==fixed_balance)
         stop_usd=risk_input*fixed_balance_usd/100;
      if(stop_usd==0)
         stop_usd=1;
      double sl=0;
      if (stop_calculator_input == sl_kgsr_calculator)
         {
         sl=kg_r;
         double sl_temp=sl;
         for(int counter=0; counter<=20; counter++)
           {
            sl_temp=MathMax(sl_temp,High[counter]);
           }
         sl=MathMax(sl,sl_temp);
         if (use_capchannel) sl=MathMax(sl,capchannel_u);
         if (use_envelopes) sl=MathMax(sl,envelopes_u);
         if(min_stop_pips>0) sl=MathMax(sl,Bid+min_stop_pips*Point);
         sl = sl + sl_space_pips*Point;
         }
      if (stop_calculator_input==sl_manual)
         {
         sl = Bid + (manual_stop_pips_input * Point);
         if (manual_stop_pips_input==0) sl = 0;
         }
         
      if (sl!=0)
      {
      if(Digits==5)
         lot_size= NormalizeDouble(stop_usd/(100000*pip_value*(sl-iClose(Symbol(),trigger_tf_input,1))),2);
      if(Digits==4)
         lot_size= NormalizeDouble(stop_usd/(10000*pip_value*(sl-iClose(Symbol(),trigger_tf_input,1))),2);
      if(Digits==3)
         lot_size= NormalizeDouble(stop_usd/(1000*pip_value*(sl-iClose(Symbol(),trigger_tf_input,1))),2);
      if(Digits==2)
         lot_size= NormalizeDouble(stop_usd/(100*pip_value*(sl-iClose(Symbol(),trigger_tf_input,1))),2);
      if(Digits==1)
         lot_size= NormalizeDouble(stop_usd/(10*pip_value*(sl-iClose(Symbol(),trigger_tf_input,1))),2);
      if(Digits==0)
         lot_size= NormalizeDouble(stop_usd/(1*pip_value*(sl-iClose(Symbol(),trigger_tf_input,1))),2);
         
      lot_size = lot_size * MathPow(2 , martingale_level);
      }
      
      if (lot_control_input==fixed_lot) lot_size=fixed_lot_input;
      
      if(lot_size<MarketInfo(Symbol(),MODE_MINLOT))
         lot_size=MarketInfo(Symbol(),MODE_MINLOT);
      if(lot_size>MarketInfo(Symbol(),MODE_MAXLOT))
         lot_size=MarketInfo(Symbol(),MODE_MAXLOT);


      if(do_trade_input && closing_options==fix_tp)
        {
         double tp=MathMin(Bid-(kg_r-iClose(Symbol(),trigger_tf_input,1)),capchannel_m);
         tp=MathMin(Bid-(sl-Bid)*fix_tp_risk_reward_ratio,tp);
         if (do_trailing_stop) tp=0;
         
         Print("PERFECT IS SENDING SELL ORDER.");
         Print("BID: ",Bid," | LOT: ",lot_size," | TP: ",tp," | SL: ",sl);

         int ss=OrderSend(Symbol(),OP_SELL,lot_size,Bid,0,sl,tp,comment+IntegerToString(martingale_level),magic,0,clrRed);
         if(ss>0)
           {
            if (reset_signal_after_trade) SIGNAL_RESET();
            Print("PERFECT ORDER SELL SENT.");
           }
        }

      if(do_trade_input && closing_options==close_by_capchannel)
        {
         double tp=MathMin(Bid-(kg_r-iClose(Symbol(),trigger_tf_input,1)),capchannel_d);
         tp=MathMin(Bid-(sl-Bid),tp);
         if (do_trailing_stop) tp=0;
         
         Print("PERFECT IS SENDING SELL ORDER.");
         Print("BID: ",Bid," | LOT: ",lot_size," | TP: ",tp," | SL: ",sl);

         int ss=OrderSend(Symbol(),OP_SELL,lot_size,Bid,0,sl,tp,comment+IntegerToString(martingale_level),magic,0,clrRed);
         if(ss>0)
           {
            if (reset_signal_after_trade) SIGNAL_RESET();
            Print("PERFECT ORDER SELL SENT.");
           }
        }

      if(do_trade_input && closing_options==close_by_opposit)
        {
         Print("PERFECT IS SENDING SELL ORDER.");
         Print("BID: ",Bid," | LOT: ",lot_size," | TP: ","0"," | SL: ",sl);

         int ss=OrderSend(Symbol(),OP_SELL,lot_size,Bid,0,sl,0,comment+IntegerToString(martingale_level),magic,0,clrRed);
         if(ss>0)
           {
            if (reset_signal_after_trade) SIGNAL_RESET();
            Print("PERFECT ORDER SELL SENT.");
           }
        }
      if(send_alert)
        {
         Alert(Symbol(),"   ",capchannel_tf,"   SELL!");
        }
     }
   if(do_risk_free_capchannel==caprf_m)
     {
      for(int cnt=0; cnt<OrdersTotal(); cnt++)
        {
         if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
            continue;
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_BUY &&
            Bid>=capchannel_m &&
            OrderStopLoss()<OrderOpenPrice())
           {
            Print("PERFECT IS SENDING CAP CHANNEL M RISK FREE FOR BUY ORDER.");
            int bm=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+risk_free_space_pips*Point,OrderTakeProfit(),0,clrGreen);
            if(bm>0)
              {
               Print("PERFECT ORDER BUY RISK FREE IS DONE.");
              }
           }
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_SELL &&
            Ask<=capchannel_m &&
            OrderStopLoss()>OrderOpenPrice())
           {
            Print("PERFECT IS SENDING CAP CHANNEL M RISK FREE FOR SELL ORDER.");
            int sm=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-risk_free_space_pips*Point,OrderTakeProfit(),0,clrGreen);
            if(sm>0)
              {
               Print("PERFECT ORDER SELL RISK FREE IS DONE.");
              }
           }
        }
     }
   if(do_risk_free_capchannel==caprf_ud)
     {
      for(int cnt=0; cnt<OrdersTotal(); cnt++)
        {
         if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
            continue;
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_BUY &&
            Bid>=capchannel_u &&
            OrderStopLoss()<OrderOpenPrice())
           {
            Print("PERFECT IS SENDING CAP CHANNEL U RISK FREE FOR BUY ORDER.");
            int bm=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+risk_free_space_pips*Point,OrderTakeProfit(),0,clrGreen);
            if(bm>0)
              {
               Print("PERFECT ORDER BUY RISK FREE IS DONE.");
              }
           }
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_SELL &&
            Ask<=capchannel_d &&
            OrderStopLoss()>OrderOpenPrice())
           {
            Print("PERFECT IS SENDING CAP CHANNEL D RISK FREE FOR SELL ORDER.");
            int sm=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-risk_free_space_pips*Point,OrderTakeProfit(),0,clrGreen);
            if(sm>0)
              {
               Print("PERFECT ORDER SELL RISK FREE IS DONE.");
              }
           }
        }
     }
   if(do_risk_free_envelopes==envrf_m)
     {
      for(int cnt=0; cnt<OrdersTotal(); cnt++)
        {
         if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
            continue;
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_BUY &&
            Bid>=envelopes_m &&
            OrderStopLoss()<OrderOpenPrice())
           {
            Print("PERFECT IS SENDING ENVELOPES M RISK FREE FOR BUY ORDER.");
            int bm=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+risk_free_space_pips*Point,OrderTakeProfit(),0,clrGreen);
            if(bm>0)
              {
               Print("PERFECT ORDER BUY RISK FREE IS DONE.");
              }
           }
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_SELL &&
            Ask<=envelopes_m &&
            OrderStopLoss()>OrderOpenPrice())
           {
            Print("PERFECT IS SENDING ENVELOPES M RISK FREE FOR SELL ORDER.");
            int sm=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-risk_free_space_pips*Point,OrderTakeProfit(),0,clrGreen);
            if(sm>0)
              {
               Print("PERFECT ORDER SELL RISK FREE IS DONE.");
              }
           }
        }
     }
   if(do_risk_free_envelopes==envrf_ud)
     {
      for(int cnt=0; cnt<OrdersTotal(); cnt++)
        {
         if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
            continue;
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_BUY &&
            Bid>=envelopes_u &&
            OrderStopLoss()<OrderOpenPrice())
           {
            Print("PERFECT IS SENDING ENVELOPES U RISK FREE FOR BUY ORDER.");
            int bm=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+risk_free_space_pips*Point,OrderTakeProfit(),0,clrGreen);
            if(bm>0)
              {
               Print("PERFECT ORDER BUY RISK FREE IS DONE.");
              }
           }
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_SELL &&
            Ask<=envelopes_d &&
            OrderStopLoss()>OrderOpenPrice())
           {
            Print("PERFECT IS SENDING ENVELOPES D RISK FREE FOR SELL ORDER.");
            int sm=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-risk_free_space_pips*Point,OrderTakeProfit(),0,clrGreen);
            if(sm>0)
              {
               Print("PERFECT ORDER SELL RISK FREE IS DONE.");
              }
           }
        }
     }
   if(do_risk_free_macd)
     {
      for(int cnt=0; cnt<OrdersTotal(); cnt++)
        {
         if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
            continue;
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_BUY &&
            macd_signal_instant=="sell" &&
            OrderStopLoss()<OrderOpenPrice())
           {
            Print("PERFECT IS SENDING MACD RISK FREE FOR BUY ORDER.");
            int bm=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+risk_free_space_pips*Point,OrderTakeProfit(),0,clrGreen);
            if(bm>0)
              {
               Print("PERFECT ORDER BUY RISK FREE IS DONE.");
              }
           }
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_SELL &&
            macd_signal_instant=="buy" &&
            OrderStopLoss()>OrderOpenPrice())
           {
            Print("PERFECT IS SENDING MACD RISK FREE FOR SELL ORDER.");
            int sm=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-risk_free_space_pips*Point,OrderTakeProfit(),0,clrGreen);
            if(sm>0)
              {
               Print("PERFECT ORDER SELL RISK FREE IS DONE.");
              }
           }
        }
     }
   if(do_risk_free_ichi)
     {
      for(int cnt=0; cnt<OrdersTotal(); cnt++)
        {
         if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
            continue;
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_BUY &&
            Bid<ichi_a_0 &&
            Bid<ichi_b_0 &&
            OrderStopLoss()<OrderOpenPrice())
           {
            Print("PERFECT IS SENDING ICHI RISK FREE FOR BUY ORDER.");
            int bm=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+risk_free_space_pips*Point,OrderTakeProfit(),0,clrGreen);
            if(bm>0)
              {
               Print("PERFECT ORDER BUY RISK FREE IS DONE.");
              }
           }
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_SELL &&
            Ask>ichi_a_0 &&
            Ask>ichi_b_0 &&
            OrderStopLoss()>OrderOpenPrice())
           {
            Print("PERFECT IS SENDING ICHI RISK FREE FOR SELL ORDER.");
            int sm=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-risk_free_space_pips*Point,OrderTakeProfit(),0,clrGreen);
            if(sm>0)
              {
               Print("PERFECT ORDER SELL RISK FREE IS DONE.");
              }
           }
        }
     }
   if(do_risk_free_sar)
     {
      for(int cnt=0; cnt<OrdersTotal(); cnt++)
        {
         if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
            continue;
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_BUY &&
            Bid<sar_0 &&
            OrderStopLoss()<OrderOpenPrice())
           {
            Print("PERFECT IS SENDING SAR RISK FREE FOR BUY ORDER.");
            int bm=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+risk_free_space_pips*Point,OrderTakeProfit(),0,clrGreen);
            if(bm>0)
              {
               Print("PERFECT ORDER BUY RISK FREE IS DONE.");
              }
           }
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_SELL &&
            Ask>sar_0 &&
            OrderStopLoss()>OrderOpenPrice())
           {
            Print("PERFECT IS SENDING SAR RISK FREE FOR SELL ORDER.");
            int sm=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-risk_free_space_pips*Point,OrderTakeProfit(),0,clrGreen);
            if(sm>0)
              {
               Print("PERFECT ORDER SELL RISK FREE IS DONE.");
              }
           }
        }
     }
   if(do_risk_free_ma)
     {
      for(int cnt=0; cnt<OrdersTotal(); cnt++)
        {
         if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
            continue;
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_BUY &&
            Bid<ma &&
            OrderStopLoss()<OrderOpenPrice())
           {
            Print("PERFECT IS SENDING MA RISK FREE FOR BUY ORDER.");
            int bm=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+risk_free_space_pips*Point,OrderTakeProfit(),0,clrGreen);
            if(bm>0)
              {
               Print("PERFECT ORDER BUY RISK FREE IS DONE.");
              }
           }
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_SELL &&
            Ask>ma &&
            OrderStopLoss()>OrderOpenPrice())
           {
            Print("PERFECT IS SENDING MA RISK FREE FOR SELL ORDER.");
            int sm=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-risk_free_space_pips*Point,OrderTakeProfit(),0,clrGreen);
            if(sm>0)
              {
               Print("PERFECT ORDER SELL RISK FREE IS DONE.");
              }
           }
        }
     }
   if(do_risk_free_megafxprofit)
     {
      for(int cnt=0; cnt<OrdersTotal(); cnt++)
        {
         if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
            continue;
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_BUY &&
            megafxprofit_green==0 &&
            megafxprofit_red<0 &&
            OrderStopLoss()<OrderOpenPrice())
           {
            Print("PERFECT IS SENDING MEGA FX PROFIT RISK FREE FOR BUY ORDER.");
            int bm=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+risk_free_space_pips*Point,OrderTakeProfit(),0,clrGreen);
            if(bm>0)
              {
               Print("PERFECT ORDER BUY RISK FREE IS DONE.");
              }
           }
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_SELL &&
            megafxprofit_green>0 &&
            megafxprofit_red==0 &&
            OrderStopLoss()>OrderOpenPrice())
           {
            Print("PERFECT IS SENDING MEGA FX PROFIT RISK FREE FOR SELL ORDER.");
            int sm=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-risk_free_space_pips*Point,OrderTakeProfit(),0,clrGreen);
            if(sm>0)
              {
               Print("PERFECT ORDER SELL RISK FREE IS DONE.");
              }
           }
        }
     }
   if(do_risk_free_percent)
     {
      for(int cnt=0; cnt<OrdersTotal(); cnt++)
        {
         if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
            continue;
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_BUY &&
            Bid>=(OrderOpenPrice()+OrderTakeProfit())/2 &&
            OrderStopLoss()<OrderOpenPrice())
           {
            Print("PERFECT IS SENDING % RISK FREE FOR BUY ORDER.");
            int bm=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+risk_free_space_pips*Point,OrderTakeProfit(),0,clrGreen);
            if(bm>0)
              {
               Print("PERFECT ORDER BUY RISK FREE IS DONE.");
              }
           }
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_SELL &&
            Ask<=(OrderOpenPrice()+OrderTakeProfit())/2 &&
            OrderStopLoss()>OrderOpenPrice())
           {
            Print("PERFECT IS SENDING % RISK FREE FOR SELL ORDER.");
            int sm=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-risk_free_space_pips*Point,OrderTakeProfit(),0,clrGreen);
            if(sm>0)
              {
               Print("PERFECT ORDER SELL RISK FREE IS DONE.");
              }
           }
        }
     }
   if(do_target_free_percent)
     {
      for(int cnt=0; cnt<OrdersTotal(); cnt++)
        {
         if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
            continue;
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_BUY &&
            Bid<=(OrderOpenPrice()+OrderStopLoss())/2 &&
            OrderTakeProfit()>OrderOpenPrice()+target_free_space_pips*Point)
           {
            Print("PERFECT IS SENDING % TARGET FREE FOR BUY ORDER.");
            int bm=OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),OrderOpenPrice()+target_free_space_pips*Point,0,clrGreen);
            if(bm>0)
              {
               Print("PERFECT ORDER BUY TARGET FREE IS DONE.");
              }
           }
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_SELL &&
            Ask>=(OrderOpenPrice()+OrderStopLoss())/2 &&
            OrderTakeProfit()<OrderOpenPrice()-target_free_space_pips*Point)
           {
            Print("PERFECT IS SENDING % TARGET FREE FOR SELL ORDER.");
            int sm=OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),OrderOpenPrice()-target_free_space_pips*Point,0,clrGreen);
            if(sm>0)
              {
               Print("PERFECT ORDER SELL TARGET FREE IS DONE.");
              }
           }
        }
     }
   if(do_trailing_stop && Volume[0]<=1)
     {
     Comment(kg_r_trailing_stop,"\n",kg_s_trailing_stop);
     
      for(int cnt=0; cnt<OrdersTotal(); cnt++)
        {
         if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
            continue;
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_BUY &&
            Bid>=kg_s_trailing_stop &&
            kg_r_trailing_stop>OrderOpenPrice())
           {
            Print("PERFECT IS SENDING TRAILING STOP FOR BUY ORDER.");
            int bm=OrderModify(OrderTicket(),OrderOpenPrice(),kg_r_trailing_stop,OrderTakeProfit(),0,clrGreen);
            if(bm>0)
              {
               Print("PERFECT ORDER BUY TRAILING STOP IS DONE.");
              }
           }
         if(OrderSymbol()==Symbol() &&
            OrderMagicNumber()==magic &&
            OrderType()==OP_SELL &&
            Ask<=kg_r_trailing_stop &&
            kg_r_trailing_stop<OrderOpenPrice())
           {
            Print("PERFECT IS SENDING TRAILING STOP FOR SELL ORDER.");
            int sm=OrderModify(OrderTicket(),OrderOpenPrice(),kg_r_trailing_stop,OrderTakeProfit(),0,clrGreen);
            if(sm>0)
              {
               Print("PERFECT ORDER SELL TRAILING STOP IS DONE.");
              }
           }
        }
     }
          
   string martingale_text="";
   if(lot_control_input==fixed_risk)
      martingale_text+="FIX RISK "+DoubleToStr(risk_input,1)+" %";
   if(lot_control_input==positive_martingale)
      martingale_text+="POSITIVE MARTINGALE "+DoubleToStr(risk_input,1)+" %"+"   "+"MARTI LEVEL : +"+IntegerToString(martingale_level);
   if(lot_control_input==negative_martingale)
      martingale_text+="NEGATIVE MARTINGALE "+DoubleToStr(risk_input,1)+" %"+"   "+"MARTI LEVEL : -"+IntegerToString(martingale_level);
   ObjectSetText(comment+"marti",martingale_text,8,"Arial Bold","Arial Bold");
    
  }
//+------------------------------------------------------------------+

// void Label(string object_name, string text, string font, int font_size, color font_color,int corner, int x, int y, bool back)
void OBJECT_LABEL(string objname,int anchor,int cor,int x,int y,string text,int wid,color col,string font)
  {
   ObjectDelete(objname);
   ObjectCreate(objname, OBJ_LABEL, 0, 0, 0);
   ObjectSet(objname, OBJPROP_XDISTANCE, x);
   ObjectSet(objname, OBJPROP_YDISTANCE, y);
   ObjectSet(objname, OBJPROP_CORNER, cor);
   ObjectSet(objname, OBJPROP_ANCHOR, anchor);
   ObjectSet(objname, OBJPROP_SELECTABLE, false);
   ObjectSet(objname, OBJPROP_BACK, false);
   ObjectSetText(objname,text,wid,font,col);
  }
//+------------------------------------------------------------------+
void SIGNAL_RESET()
   {
   if (use_capchannel) capchannel_signal="None";
   if (use_envelopes) envelopes_signal="None";
   if (use_ichi_instant) ichi_signal_instant="None";
   if (use_ichi_switch) ichi_signal_switch="None";   
   if (use_ma) ma_signal="None";
   if (use_macd_instant) macd_signal_instant="None";
   if (use_macd_switch) macd_signal_switch="None";
   if (use_megafxprofit) megafxprofit_signal="None";
   if (use_rsi) rsi_signal="None";
   if (use_sar) sar_signal="None";
   }