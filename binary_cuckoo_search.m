function cuckoo_chromo=binary_cuckoo_search(raw1,training_data_size,max_len,t)

num_of_particle=2;
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
    ch1 = t{1,1}(i,1);
    ttemp=ch1{1,1};
   feature_class{j,1}=ttemp(1,size(ttemp,2));
   classes_final(j,1)=str2num(ttemp(1,size(ttemp,2)));
   count = count+1;
end


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
new_nests=3;
iter=1;
while counter < iter%for j=1:size(r,1)%(1,:)
 counter=counter+1;
%===========================================
  cromo1_new=cromo1;
  
        for k=1:size(cromo1,1)
        
            counters=1;
            while counters<=new_nests%x_t(m,2)
   
        %tr = randi([st_p st_e],1,1);
 
        r_pos = randi(elements,1,1);
     
    
        %new_element = Alpha(1,r_pos);
    if cromo1_new(k,r_pos)==1
        cromo1_new(k,r_pos) =0;% new_element;
    else
         cromo1_new(k,r_pos) =1;% new_element;
    end
        counters=counters+1;
        
            end
        end
        fitness=text_fitness(cromo1,raw1,max_len,training_data_size,classes_final,feature_vect);
        fitness_new=text_fitness(cromo1_new,raw1,max_len,training_data_size,classes_final,feature_vect);
        
        for k=1:size(cromo1,1)
           if  fitness(k,1)<=fitness_new(k,1)
            cromo1(k,:)=cromo1_new(k,:);
           end
        end
        cromo1_new=[];
%[Cd cb] = sort(fitness);

end

fitness=text_fitness(cromo1,raw1,max_len,training_data_size,classes_final,feature_vect);
[Cc Ii]=max(fitness);
cuckoo_chromo = r(Ii,:);

end

