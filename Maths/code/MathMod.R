#GENETIC DRIFT SIMULATOR
sim_gen_drift <- function(p0=0.5, t=10, N=10) #parameter values
{
#INITIALISATION
#Popu is a list storing all allelic configurations
# from gen 0 to t thr4 t+1 
population <- list()
length(population) <- t+1
#give names to elements of population
for (i in 1:length(population))
{
    names(population)[i] <- paste (c("generation", i - 1), collapse = " ")
}
#keep track on allele freq over time - as a vector
allele.freq <- rep(NA, t+1)

#number of 0 allele at start
k<- round(2*N*p0)
population[[1]] <- matrix(sample(c(rep(0, k), rep(1, 2*N-k))), nr = 2)
allele.freq[1] <- sum(population[[1]] == 0) / (2*N)
#PROPAGATION

for (i in 1:t)
    {
        #Current gen allele freq
        population[[i+1]] <- matrix(sample(0:1, size=2*N, 
        prob=c(allele.freq[i], 1-allele.freq[i]), 
        replace = TRUE), nr=2)
        #allele freq at next gen
        allele.freq[i+1] <- sum(population[[i+1]]==0)/(2*N)
    }
#OUTPUTS
return(list(population=population, allele.freq=allele.freq))
}

sim_gen_drift()

#MEAN, VARIANCE, DISTRIBUTION OF ALLELE FREQ
result_MC <- rep(NA, 10000)
for (i in 1:length(result_MC))
{
    result_MC[i] <- sim_gen_drift(p0=0.5, N=200, t=10)$allele.freq[11]
}

#MC approximations
mean(result_MC)
var(result_MC)
#histogram of 10000 simulated final allele freq.
hist(result_MC, main = "Histogram of 10000 final allele freq", xlab= "allele frequency")

#HOW MANY GEN WILL 0 allele persist before extinction


########################################
###CODE simulating genetic drift over time under a simplified popu based model - trakcs only allele frequencies
#ignores individual level details 
#uses binomial distribution
sim_genetic_drift2<-function(N=10, t=5, p0=0.5)
{
    # A VECTOR FOR ALLELE FREQ
    allele.freq<-rep(NA, t+1)
    # INITIALISE
    allele.freq[1]<-p0
    # PROPAGATION
    # DIVIDE COUNT BY 2*N TO GET FREQ
    for (i in 1:t)
    {
        allele.freq[i+1]<-rbinom(1, size=2*N, prob=allele.freq[i])/(2*N)
    }
    # RETURN AND EXIT
    return(allele.freq)
}
     

# TEST RUN
sim_genetic_drift2()
#output produces vector of allele freq. de to sampling efefcts in a finite popu


##DRIFT AND POPU SIZE 
#CODE demonstrates relationship btw genetic drift and popu size by simulating allele freq. changes under 2 scenarios
#small popu = 50 and large popu = 500
# SMALL N=50 SCENARIO, WITH 20 REPLICATEAS
af_N50<-matrix(nr=20, nc=51)
for (i in 1:nrow(af_N50))
{
    af_N50[i,]<-sim_genetic_drift2(N=50, t=50)
}
# LARGE N=500 SCENARIO, WITH 20 REPLICATES
af_N500<-matrix(nr=20, nc=51)
for (i in 1:nrow(af_N500))
{
    af_N500[i,]<-sim_genetic_drift2(N=500, t=50)
}
# PLOTS ALLELE FREQ TRAJECTORIES
matplot(0:50, t(af_N50), type='l', ylim=c(0, 1), 
        xlab='generations', ylab='allele frequency', main='N=50', lwd=2)
matplot(0:50, t(af_N500), type='l', ylim=c(0, 1), 
        xlab='generations', ylab='allele frequency', main='N=500', lwd=2)



###MONTE CARLO METHOD
# MEAN, VARIANCE, AND DISTRIBUTION OF ALLELE FREQ DUE TO DRIFT
# p0=0.5, N=200, t=10
# 10000 INDEPENDENT SIMS (OR LOCI), NOTE THAT WE'RE ONLY INTERESTED IN THE FINAL ALLELE FREQ
final_af<-rep(NA, 10000)
for (i in 1:length(final_af))
{
    final_af[i]<-sim_genetic_drift2(N=200, p0=0.5, t=10)[11]
}
# OUR APPROXIMATIONS 
mean(final_af)
var(final_af)
hist(final_af, xlab='allele freq', main='Histogram of 10000 final allele freq')


#VARIANCE OF MC estimates
 #THE doParallel PACKAGE
require(doParallel)
# NUMBERS OF INDEPENDENT RUNS (LOCI)
num_indep_loci<-c(50, 100, 200, 500, 1000, 2000)
# LOCAL MULTI-CORE CLUSTER SETUP
cl<-makeCluster(44)
registerDoParallel(cl)
# FOR EACH VALUE OF INDEP LOCI
result<-foreach(i=1:6, .combine=cbind) %dopar%
{
    # WE WANT TO GET 1000 Var(p_t) ESTIMATES VIA MC
    temp_result<-rep(NA, 1000)
    for (j in 1:length(temp_result))
        {
        temp<-rep(NA, num_indep_loci[i])
        for (k in 1:num_indep_loci[i])
            {
                temp[k]<-sim_genetic_drift2(p0=0.5, N=200, t=10)[11]
            }
        temp_result[j]<-var(temp)
    }
    return(temp_result)
}
stopCluster(cl)
dim(result)

# PLOT THE UNCERTAINTY AROUND THESE VARIANCE ESTIMATES (i.e. SAMPLE VARIANCE OF 1000 REPEATED VARIANCE ESTIMTAES)
plot(num_indep_loci, apply(result, 2, var), 
    xlab='number of loci used to produce one variance estimate', 
    ylab='variance (or uncertainty) around the estimate')

# OR PLOT THE RECIPROCAL OF THE UNCERTAINTY?
plot(num_indep_loci, 1/apply(result, 2, var), 
    xlab='number of loci used to produce one variance estimate', 
    ylab='1/variance (or uncertainty) around the estimate')
abline(lm(1/apply(result, 2, var)~num_indep_loci), lty=2)


##PERSISTENCE TIME OF ALLELE

# MODIFY sim_genetic_drift2() TO RUN UNTIL THE LOCUS IS FIXED
sim_genetic_drift3<-function(N=10, p0=0.5)
{
    # WE CAN USE UPDATE AND REUSE THE SAME VARIABLE p
    p<-p0
    # KEEP TRACK OF t
    t<-0
    # PROPAGATION. WHILE IT REMAINS POLYMORPHIC
    while (p>0 & p<1)
    {
        p<-rbinom(1, size=2*N, prob=p)/(2*N)
        t<-t+1
    }
    # RETURN t AND EXIT
    return(t)
}
     

# MEAN PERSISTENCE TIME, AND ITS DISTRIBUTION
# p0=0.02, N=200
# DON'T TRY WITH LARGE N
persistence_time<-rep(NA, 10000)
for (i in 1:length(persistence_time))
{
        persistence_time[i]<-sim_genetic_drift3(p0=0.02, N=200)
}
mean(persistence_time)
var(persistence_time)
hist(persistence_time)
#MC persistence has a huge varuance. distribution is heavily skewed w long tail. 
     


#######################    
##SIMULATOR DRIFT SELECTION

sim_drift_selection<-function(N=10, p0=0.5, t=5, s=0.2, h=0.5)
{
    # LET US WRITE A FUNCTION WITHIN A FUNCTION. A FUNCTION TO CALCULATE GENOTYPIC COUNT FROM A MATRIX
    cal.gt<-function(x)
    {
        y<-x[1,]+x[2,]
        # RETURN COUNTS OF 00, 01, 11
        return(c(sum(y==0), sum(y==1), sum(y==2)))
    }
    # THE BIG LIST OF MATRICES (TO BE FILLED IN LATER)
    population<-list()
    length(population)<-t+1
    # GIVE NAMES TO THE ELEMENTS
    for (i in 1:(t+1))
    {
        names(population)[i]<-paste(c('generation_', i-1), collapse='')
    }
    # A VECTOR FOR ALLELE FREQ
    allele.freq<-rep(NA, t+1)
    # INITIALISE
    # NUMBER OF "0" ALLELE AT THE START, GOVERNED BY p0
    k<-round(2*N*p0)
    population[[1]]<-matrix(sample(c(rep(0, k), rep(1, 2*N-k))), nr=2)
    # THE INITIAL ALLELE FREQ
    allele.freq[1]<-sum(population[[1]]==0)/(2*N)
    # FITNESS FOR THE THREE GENOTYPES
    w<-c(1, 1-h*s, 1-s)
    # PROPAGATION
    for (i in 1:t)
    {
        # CALCULATE NEW GAMETIC FREQ, BUT THIS TIME REQUIRES GENOTYPIC INFO
        gt<-cal.gt(population[[i]])
        after_selection<-gt*w
        p<-(gt[1]*w[1]+0.5*gt[2]*w[2])/sum(after_selection)
        population[[i+1]]<-matrix(sample(0:1, size=2*N, prob=c(p, 1-p), replace=T), nr=2)
        # UPDATE NEW FREQ
        allele.freq[i+1]<-sum(population[[i+1]]==0)/(2*N)
    }
    # RETURN A BIG LIST, EXIT
    return(list(population=population, allele.freq=allele.freq))
}
     

# TEST RUN
sim_drift_selection()
     
# N=100, s=0.1, h=0.5, p0=0.05
# 20 REPLICATES
result<-matrix(nc=31, nr=20)
for (i in 1:nrow(result))
{
    # RUN ONE SIM, RECORD THE ALLELE FREQ OF "0"
    result[i,]<-sim_drift_selection(N=100, s=0.2, h=0.5, p0=0.05, t=30)$allele.freq
}
# PLOT
matplot(0:30, t(result), ylim=c(0, 1), type='l', lwd=2, 
       xlab='generations', ylab='allele frequency of "0"')
abline(h=0, col='grey', lty=40)




##DRIFT MIGRATION MODEL
sim_drift_migration<-function(p0_A=0.5, p0_B=0.5, t=10, N_A, N_B, m_A, m_B)
{
# AS WE HAVE TWO POPULATAIONS WE NEED TWO LISTS TO STORE THE ALLELIC CONFIGURATIONS
#  FROM GEN 0 TO t, HENCE LENGTH (t+1)
population.A<-list()
population.B<-list()
length(population.A)<-t+1
length(population.B)<-t+1
# (OPTIONAL) GIVE NAMES TO THE ELEMENTS OF population
names(population.A)<-rep(NA, t+1)
names(population.B)<-rep(NA, t+1)
for (i in 1:(t+1))
	{
	names(population.A)[i]<-paste(c('generation', i-1), collapse='')
	names(population.B)[i]<-paste(c('generation', i-1), collapse='')
	}
# TWO VECTORS FOR TWO ALLELE FREQUENCIES OVER TIME
allele.freq.A<-rep(NA, t+1)
allele.freq.B<-rep(NA, t+1)
# INITIALISATION. WE NEED TO INITIALISE BOTH POPULATIONS. SAME AS BEFORE. 
# INITIALISE POPULATION A AND ITS FREQ
k<-ceiling(2*N_A*p0_A)
population.A[[1]]<-matrix(sample(c(rep(0, k), rep(1, 2*N_A-k))), nr=2)
allele.freq.A[1]<-sum(population.A[[1]]==0)/(2*N_A)
# DO THE SAME FOR POPULATION B. BEWARE OF TYPO
k<-ceiling(2*N_B*p0_B)
population.B[[1]]<-matrix(sample(c(rep(0, k), rep(1, 2*N_B-k))), nr=2)
allele.freq.B[1]<-sum(population.B[[1]]==0)/(2*N_B)
# PROPAGATION
for (i in 1:t)
	{
	# THE GAMETE FREQ ISN'T THE SAME AS ALLELE FREQ AS WE NEED TO TAKE MIGRATION INTO ACCOUNT
	# THE GAMETE FREQ FOR POPULATION A IS (1-m_A) OF EXISTING ALLELE FREQ IN THE SAME POPULATION, PLUS m_A OF ALLELE FREQ IN POPULATION B (THOSE WHO MOVED FROM B TO A). 
	gamete.freq.A<-(1-m_A)*allele.freq.A[i]+m_A*allele.freq.B[i]
	gamete.freq.B<-(1-m_B)*allele.freq.B[i]+m_B*allele.freq.A[i]
	# THEN WE CAN SAMPLE THE NEXT GEN WITH THE GAMETE FREQ AFTER MIGRATION
	population.A[[i+1]]<-matrix(sample(0:1, size=2*N_A, prob=c(gamete.freq.A, 1-gamete.freq.A), replace=T), nr=2)
	population.B[[i+1]]<-matrix(sample(0:1, size=2*N_B, prob=c(gamete.freq.B, 1-gamete.freq.B), replace=T), nr=2)
	# CALCULATE THE NEW ALLELE FREQ
	allele.freq.A[i+1]<-sum(population.A[[i+1]]==0)/(2*N_A)
	allele.freq.B[i+1]<-sum(population.B[[i+1]]==0)/(2*N_B)
	}
# RETURN
return(list(population.A=population.A, population.B=population.B, allele.freq.A=allele.freq.A, allele.freq.B=allele.freq.B))
}


##FST
# PAIRWISE FST WITH 2000 LOCI, PARALLELISED
require(doParallel)
cl<-makeCluster(44)
registerDoParallel(cl)
# FIRST SCENARIO. MIGRATION RATE 0.05
result_m0.05<-foreach(i=1:2000, .combine='rbind') %dopar%
{
    # SIM THE TWO POPULATIONS
    temp<-sim_drift_migration(p0_A=0.5, p0_B=0.5, N_A=1000, N_B=1000, t=50, m_A=0.05, m_B=0.05)
    # AVERAGE OF TWO ALLELE FREQ
    z<-(temp$allele.freq.B)/2
    # FST, CHECK FORMULA
    FST<-(temp$allele.freq.B)^2/(z*(1-z))
    return(FST)
}
# SECOND SCENARIO. MIGRATION RATE 0.1
result_m0.1<-foreach(i=1:2000, .combine='rbind') %dopar%
{
    # SIM THE TWO POPULATIONS
    temp<-sim_drift_migration(p0_A=0.5, p0_B=0.5, N_A=1000, N_B=1000, t=50, m_A=0.1, m_B=0.1)
    # AVERAGE OF TWO ALLELE FREQ
    z<-(temp$allele.freq.B)/2
    # FST, CHECK FORMULA
    FST<-(temp$allele.freq.B)^2/(z*(1-z))
    return(FST)
}
stopCluster(cl)

# PLOT THE AVERAGE FST OVER TIME
plot(0:50, apply(result_m0.05, 2, mean), xlab='generations', ylab='FST')
points(0:50, apply(result_m0.1, 2, mean), xlab='generations', ylab='FST', col='red', pch=3)
legend('bottomright', legend=c('N=1000, m=0.05', 'N=1000, m=0.1'), col=1:2, pch=c(1,3))
    

##COALESCENT THEORY
parents<-LETTERS[1:10]
parents
# USE RANDOM SEED TO GET THE SAME RANDOM DRAWS. WORK FOR >=R-4.0
set.seed(12345)
offspring<-sample(parents, size=10, replace=T)
offspring


col<-rainbow(10)
plot(1:10, rep(1, 10), ylim=c(0,1.2), col=col, pch=16, cex=2, 
    xlab='individuals', ylab='generation', yaxt='n')
for (i in 1:10)
    {text(x=i, y=1.1, labels=LETTERS[i], col=col[i])}
axis(2, at=0:1, labels=c('current gen', 'parental gen'))
points(1:10, rep(0, 10), col=col[match(offspring, LETTERS[1:10])], pch=16, cex=2)
for (i in 1:10)
{
    arrows(match(offspring[i], LETTERS[1:10]), 1, i, 0, col=col[match(offspring[i], LETTERS[1:10])], lty=2, lwd=2)
}
     
