function [mdl final_feature]=genetic_wolf_selection(max_len)


max_len=1400;
i=2;
 x=num2str(i);
y=num2str(i+max_len);
st =strcat('E',x,':BV',y);
[num1,txt1,raw1] = xlsread('RansomwareData.csv',st);
ar =fopen('IDS.txt');
 t = textscan(ar,'%s','delimiter','%, %?');
 
tr_ratio = 1;%str2num(get(handles.edit_ratio,'string'));
testing_data_size = max_len;
training_data_size = max_len*tr_ratio;
feature_loc = [5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40];

total_epochs = 5;%str2num(get(handles.edit_epochs_1,'string'));
layer_neurons = [5,3];

cuckoo_chromo=binary_cuckoo_search(raw1,training_data_size,max_len,t);
%------Generate Population--Algorithm---------------

k = 13;%input('Enter Number of Clusters');
%k =2;
num_of_particle =9;%input('Enter Number of Particles');
iter = 1;%input('Enter Number of Iteration');
chgg = floor(k/2);
elements = size(raw1,2)-1;%+1;%size(img_name,1);
r=[];
for i=1:num_of_particle

    items = randi([20 elements],[1,1]);
    x = zeros(1,elements);
    count=1;
    while count<=items
        xt = randi([1 elements],[1,1]);
        x(1,xt)=1;
        count=count+1;
    end
    r=[r;x];
end
%r = unique(randi(k,[num_of_particle,k]),'rows'); % in this matrix row represent particle and colum represent centroid
%r=unique(r,'column');


%-----------------------------------------------------

for j=1:size(raw1,1)

    for k=2:size(raw1,2)
   temp =raw1{j,k};
   feature_vect(j,k-1) = temp;
    end
    ch1 = t{1,1}(j,1);
    ttemp=ch1{1,1};
   feature_class{j,1}=ttemp(1,size(ttemp,2));
   semicolon = strfind(ttemp,';');
 srt=ttemp(1,semicolon(1,size(semicolon,2))-1);
   trt=str2num(srt);
   ttemp
   if trt>0
   classes_final(j,1)=1;
   else
       classes_final(j,1)=0;
   end
   count = count+1;
end
classes_final
% 
% [row col] = size(feature_class);
% chked = zeros(row,1);
% m = 1;
% for i = 1:row 
%     temp_1 = feature_class{i,1};
%     k = 1;
%     if ~(chked(i,1))
%         for j = i:row
%             temp_2 = feature_class{j,1};
%             if strcmp(temp_1,temp_2) && ~(chked(j,1))
%                 feature_class_index{m,1} = feature_class{i,1};
%                 feature_class_index{m,2} = k;
%                 chked(j,1) = 1;
%                 k = k + 1;
%             end
%         end
%         m = m + 1;
%     end
% end
% 
% [row col] = size(feature_class);
% [row1 col1] = size(feature_class_index);
% 
% for i = 1:row 
%     temp_1 = feature_class{i,1};
%     for j = 1:row1
%         temp_2 = feature_class_index{j,1};
%         if strcmp(temp_1,temp_2)
%             feature_class_num(i,1) = j;
%         end
%     end
% end
% 
% [row col] = size(feature_class);
% [row1 col1] = size(feature_class_index);
% feature_class_data = cell(1,row1);
% for i = 1:row 
%     temp_1 = feature_class{i,1};
%     for j = 1:row1
%         temp_2 = feature_class_index{j,1};
%         if strcmp(temp_1,temp_2)
%             feature_class_num(i,1) = j;
%             feature_class_data{1,j} = [feature_class_data{1,j}; feature_vect(i,:)]; 
%         end
%     end
% end
% 
% classes = {'normal','dos','probe','r2l','u2r'};
% class_1 = {'normal'};
% class_2 = {'back','land','neptune','pod','smurf','teardrop'};
% class_3 = {'ipsweep','nmap','portsweep','satan'};
% class_4 = {'ftp_write','guess_passwd','imap','multihop','phf','spy','warezclient','warezmaster'};
% class_5 = {'buffer_overflow','loadmodule','perl','rootkit'};
% sub_classes = {class_1,class_2,class_3,class_4,class_5};
% 
% feature_class_data_temp = cell(1,5);
% for k = 1:5
%     l = size(sub_classes{1,k},2);
%     for j = 1:l
%         for i = 1:size(feature_class_index,1)
%             if strcmp(sub_classes{1,k}(1,j),feature_class_index{i,1})
%                 feature_class_data_temp{1,k} = [feature_class_data_temp{1,k}; feature_class_data{1,i}]; 
%             end
%         end
%     end
% end
% 
% k = 1;
% for i = 1:5
%     if ~isempty(feature_class_data_temp{1,i})
%         feature_class_data_final{1,k} = feature_class_data_temp{1,i};
%         classes_final{1,k} = classes{1,i};
%         k = k + 1;
%     end
% end
%-----------------------------------------------------


%r=unique(r,'column');
step_vol =5;
counter=0;
t=1;
SW=0;
k=20;
x = ones(size(r,2),1);
x_t = ones(size(r,1),1);
cromo1=r;
nVar=elements;
GreyWolves_num=size(cromo1,1);
while counter < iter%for j=1:size(r,1)%(1,:)
 %for m=1:size(r,1)
 %fitness=text_fitness_cosinetlbo(r,document_vector,k);
 counter=counter+1;
fitness=text_fitness(cromo1,raw1,max_len,training_data_size,classes_final,feature_vect);
[Cd cb] = sort(fitness);
%===========================================
  a=2-counter*((2)/iter);
  mm=floor(GreyWolves_num/3);
  countt=1;
  Alpha=cromo1(cb(1,1),:);
    for i=1:mm:size(Cd,1)%1:GreyWolves_num
        
        %clear rep2
        %clear rep3
        
        % Choose the alpha, beta, and delta grey wolves
        if countt==1
        
        Beta=cromo1(cb(2:mm),:);
        elseif countt==2
        
        else
        Delta=cromo1(cb(mm+1:2*mm),:);
        end
        countt=countt+1;
    end

    for j=1:size(Delta,1)
        % Eq.(3.4) in the paper
        c=2.*rand(1, nVar);
        % Eq.(3.1) in the paper
        teemp=(Delta(j,:)-Alpha);
        D=abs(c.*teemp);
        % Eq.(3.3) in the paper
        A=2.*a.*rand(1, nVar)-a;
        % Eq.(3.8) in the paper
        X1(j,:)=Delta(j,:)-A.*abs(D);
    end
    
    
    for j=1:size(Beta,1)
        % Eq.(3.4) in the paper
        c=2.*rand(1, nVar);
        % Eq.(3.1) in the paper
        teemp=(Beta(j,:)-Alpha);
        D=abs(c.*teemp);
        % Eq.(3.3) in the paper
        A=2.*a.*rand(1, nVar)-a;
        % Eq.(3.8) in the paper
        X2(j,:)=Beta(j,:)-A.*abs(D);
    end
        
        X3=Alpha-A.*abs(D);
        
        % Eq.(3.11) in the paper
        GreyWolves=(sum(sum(X1))+sum(sum(X2))+sum(sum(X3)))./nVar;
        
        
        for k=1:size(cromo1,1)
        
            counters=1;
            while counters<=GreyWolves%x_t(m,2)
   
        %tr = randi([st_p st_e],1,1);
 
        r_pos = randi(elements,1,1);
     
    
        new_element = Alpha(1,r_pos);
    
    
    
        cromo1(2,r_pos) = new_element;
        
        counters=counters+1;
        end
        end
        
        % Boundary checking
       % GreyWolves(i).Position=min(max(GreyWolves(i).Position,lb),ub);
        
        %GreyWolves(i).Cost=fobj(GreyWolves(i).Position')';
   
end

fitness=text_fitness(cromo1,raw1,max_len,training_data_size,classes_final,feature_vect);
[Cc Ii]=max(fitness);
st_time=tic;
cromo1 = r(Ii,:);

P = feature_vect;%P(1:training_data_size,:)';
Dt = classes_final';%T(1:training_data_size,:)';

%---------------------Normalization--------------------
final_feature=[];
for ik=1:size(cromo1,1)
    soll = cromo1(ik,:);
    soll_cuckoo = cuckoo_chromo(ik,:);
for i=1:size(P,1)
count=1; 
    for j=1:size(P,2)
   
        if soll(1,j)==1 && soll_cuckoo(1,j)==1
            final_feature(1,j)=1;
        PP(i,count)=P(i,j);%-miin)/(maax-miin);
        count=count+1;
else
final_feature(1,j)=0;
        end
    end
end
end
A=1; %00
C=2; %01
G=3; %10
T=4; %11

for i=1:size(PP,1)
count=1; 
    for j=1:size(PP,2)-1
   
        if PP(i,j)==0 && PP(i,j+1)==0
        PP_input(i,j)=A;%-miin)/(maax-miin);
        elseif PP(i,j)==0 && PP(i,j+1)==1
        PP_input(i,j)=C;
        elseif PP(i,j)==1 && PP(i,j+1)==0
        PP_input(i,j)=G;
        elseif PP(i,j)==1 && PP(i,j+1)==1
        PP_input(i,j)=T;
        end
    end
end
%for i=1:15
P=[];
P=PP_input';
%------------------------------------------------------
 mdl = fitlm(P',Dt');
 ypred = predict(mdl,P');
 acc=0;
for i=1:size(P,2)
    x=floor(ypred(i,1));
    y=floor(Dt(1,i));
   if x==y 
    acc=acc+1;
   end
end
detection_accuracy = acc/i;
detection_accuracy
final_time = toc(st_time);

final_time

end

