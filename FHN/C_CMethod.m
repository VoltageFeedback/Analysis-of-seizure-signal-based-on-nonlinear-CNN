function [Smean,Sdeltmean,Scor,tau,tw]=C_CMethod(data,max_d)
% ??????????tau?????tw
% data???????
% max_d???????
% Smean?Sdeltmean,Scor????
% tau??????????
% tw?????
N=length(data);     %???????
Smean=zeros(1,max_d);    %?????
Scmean=zeros(1,max_d);
Scor=zeros(1,max_d);
sigma=std(data);      %????????
% ??Smean,Sdeltmean,Scor
for t=1:max_d
    S=zeros(4,4);
    Sdelt=zeros(1,4);
    for m=2:5
        for j=1:4
            r=sigma*j/2;
            Xdt=disjoint(data,t);          % ?????data???t?????????
            s=0;
           for tau=1:t
                N_t=floor(N/t);                          % ????????
                Y=Xdt(:,tau);                            % ?????           
                
                %??C(1,N/t,r,t),?????Cs1(tau)=correlation_integral1(Y,r)            
                Cs1(tau)=0;
                for ii=1:N_t-1
                    for jj=ii+1:N_t
                        d1=abs(Y(ii)-Y(jj));     % ???????????????,?????
                        if r>d1
                            Cs1(tau)=Cs1(tau)+1;            
                        end
                    end
                end
                Cs1(tau)=2*Cs1(tau)/(N_t*(N_t-1));
              
                Z=reconstitution0(Y,m,1);             % ?????
                M=N_t-(m-1); 
                Cs(tau)=correlation_integral0(Z,M,r); % ??C(m,N/t,r,t)
                s=s+(Cs(tau)-Cs1(tau)^m);            % ?t???????????
           end            
           S(m-1,j)=s/tau;            
        end
        Sdelt(m-1)=max(S(m-1,:))-min(S(m-1,:));          % ????
    end
    Smean(t)=mean(mean(S));                              % ?????
    Sdeltmean(t)=mean(Sdelt);                            % ?????
    Scor(t)=abs(Smean(t))+Sdeltmean(t);
end
% ??????tau??Sdeltmean??????????t
for i=2:length(Sdeltmean)-1
    if Sdeltmean(i)<Sdeltmean(i-1)&Sdeltmean(i)<Sdeltmean(i+1)
        tau=i;
        break;
    end
end
% ??????tw??Scor??????t
for i=1:length(Scor)
    if Scor(i)==min(Scor)
        tw=i;
        break;
    end
end