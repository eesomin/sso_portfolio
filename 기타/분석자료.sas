/*전체 흡연율*/
data whole;
input ba year per;
cards;
1	2009	27.3
1	2010 27.5
1	2011	27.1
1	2012 25.8
1	2013	24.1
1	2014	24.2
2	2015	22.6
2	2016	23.9
2	2017	22.3
2	2018	22.4
2	2019	21.5
2	2020	20.6
;
run;
proc univariate data=whole normal;
var per;
run;
proc ttest data=whole;
class ba;
var per;
run;

proc gplot data=whole;
plot per*year=1;
symbol I = join;
run;

/*기대수명과 흡연율 상관분석*/
data sang;
input hper lper @@;
label hper='흡연율' lper='기대수명';
cards;
27.3	80.0	27.5	80.2	27.1	80.6	25.8	80.9	24.1	81.4	24.2	81.8
22.6	82.1	23.9	82.4	22.3	82.7	22.4	82.7	21.5	83.3	20.6	83.5
;
run;

proc corr data=sang pearson spearman nosimple;
var hper lper;
run;

proc reg data=sang;
model lper=hper;
plot lper*hper;
run;

/*남자 흡연율*/
data man;
input ba year per;
cards;
1	2009	47.0
1	2010	48.3
1	2011	47.3
1	2012	43.7
1	2013	42.2
1	2014 43.2
2	2015	39.4
2	2016	40.7
2	2017	38.1
2	2018	36.7
2	2019	35.7
2	2020	34.0
;
run;
proc gplot data=man;
plot per*year=1;
symbol I = join;
run;
/*남자 기대수명 흡연율*/
data m_sang;
input hper lper @@;
label hper='남성흡연율' lper='남성기대수명';
cards;
47.0	76.7	48.3	76.8	47.3	77.3	43.7	77.6	42.2	78.1	43.2	78.6
39.4	79.0	40.7	79.3	38.1	79.7	36.7	79.7	35.7	80.3	34.0	80.5
;
run;
proc corr data=m_sang pearson spearman nosimple;
var hper lper;
run;

proc reg data=m_sang;
model lper=hper;
plot lper*hper;
run;

/*여자 흡연율*/
data woman;
input ba year per;
cards;
1	2009	7.1
1	2010	6.3
1	2011	6.8
1	2012	7.9
1	2013	6.2
1	2014 5.7
2	2015	5.5
2	2016	6.4
2	2017	6.0
2	2018	7.5
2	2019	6.7
2	2020	6.6
;
run;
proc gplot data=woman;
plot per*year=1;
symbol I = join;
run;
/*여자 기대수명 흡연율*/
data w_sang;
input hper lper @@;
label hper='여성흡연율' lper='여성기대수명';
cards;
7.1	83.4	6.3	83.6	6.8	84.0	7.9	84.2	6.2	84.6	5.7	85.0
5.5	85.2	6.4	85.4	6.0	85.7	7.5	85.7	6.7	86.3	6.6	86.5
;
run;
proc corr data=w_sang pearson spearman nosimple;
var hper lper;
run;

proc reg data=w_sang;
model lper=hper;
plot lper*hper;
run;

/*상관 및 회귀분석*/
data stress;
input year y s_per c_per;
label year='연도' y='전체 흡연율' s_per='스트레스 지수' c_per='소비자물가 지수';
cards;
2009	27.3	31.4	83.906
2010 27.5	28.7	86.373
2011	27.1	28.7	89.850
2012 25.8	27.7	91.815
2013	24.1	24.4	93.010
2014	24.2	26.5	94.196
2015	22.6	31.0	94.861
2016	23.9	29.4	95.783
2017	22.3	30.6	97.645
2018	22.4	29.1	99.086
2019	21.5	30.8	99.466
2020	20.6	30.8	100.00
;
run;

proc corr data=stress;
var y c_per;
run;

proc reg data=stress;
model y=c_per;
plot y c_per;
run;

/*성별에 따른 차이*/
data d_sex;
input sex per @@;
cards;
1	47.0	1	48.3	1	47.3	1	43.7	1	42.2	1	43.2	1	39.4	1	40.7	1	38.1	1	36.7	1	35.7	1	34.0
2	7.1	2	6.3	2	6.8	2	7.9	2	6.2	2	5.7	2	5.5	2	6.4	2	6.0	2	7.5	2	6.7	2	6.6
;
run;
proc ttest data=d_sex cochran;
class sex;
var per;
run;

/*연령별*/
/*19세 이상*/
data nineteen;
input ba per @@;
cards;
1 26.6 1 26.9 1 26.3 1 25.0 1 23.2 1 23.3 
2 21.6 2 22.6 2 21.1 2 21.1 2 20.2 2 20.2
;
run;
proc univariate data=nineteen normal;
var per;
run;
proc ttest data=nineteen;
class ba;
var per;
run;
/*30-39*/
data age_1;
input ba per @@;
cards;
1 32.8 1 35.0 1 36.6 1 32.5 1 30.7 1 30.0 
2 27.7 2 30.4 2 25.5 2 24.7 2 24.0 2 24.0
;
run;
proc univariate data=age_1 normal;
var per;
run;
proc ttest data=age_1;
class ba;
var per;
run;
/*19-29*/
data age_2;
input ba per @@;
cards;
1 32.4 1 27.8 1 28.3 1 28.0 1 24.1 1 22.5 
2 23.7 2 25.4 2 24.4 2 23.8 2 24.8 2 24.8
;
run;
proc univariate data=age_2 normal;
var per;
run;
proc ttest data=age_2;
class ba;
var per;
run;

/*물가지수*/
data price;
input year h_per p_per;
label year='연도' h_per='전체 흡연율' p_per='소비자 물가 지수';
cards;
2009	27.3	83.906
2010 27.5	86.373
2011	27.1	89.850
2012 25.8	91.815
2013	24.1	93.010
2014	24.2	94.196
2015	22.6	94.861
2016	23.9	95.783
2017	22.3	97.645
2018	22.4	99.086
2019	21.5	99.466
2020	20.6	100.00
;
run;

proc corr data=price;
var h_per p_per;
run;

proc reg data=price;
model h_per=p_per;
plot h_per*p_per;
run;

/*노르웨이*/
data nor;
input year per;
cards;
2009 20.5
2010 19.0
2011 17.5
2012 16.0
2013 14.5
2014 13.5
2015 13.0
2016 12.0
2017 11.0
2018 11.5
2019 9.0
2020 9.0
;
run;
proc gplot data=nor;
plot per*year=1;
symbol I = join;
run;
