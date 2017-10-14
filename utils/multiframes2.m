% Create Multiframes2
function O=multiframes2(I)
[s1,s2]=size(I);
O=zeros(5*s1,s2);
O(:,1)=[I(:,1);I(:,1);I(:,1);I(:,2);I(:,3)];
O(:,2)=[I(:,1);I(:,1);I(:,2);I(:,3);I(:,4)];
O(:,end-1)=[I(:,end-3);I(:,end-2);I(:,end-1);I(:,end);I(:,end)];
O(:,end)=[I(:,end-2);I(:,end-1);I(:,end);I(:,end);I(:,end)];
for i=3:s2-2
    O(:,i)=[I(:,i-2);I(:,i-1);I(:,i);I(:,i+1);I(:,i+2)];
end

