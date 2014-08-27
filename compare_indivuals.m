%非支配解比较
function dom_relation=compare_indivuals(A,B) 
%ght_modi 2013-6-15 rewrite
%dom_relation=1, A dominate B
%dom_relation=2, B dominate A
%dom_relation=0, otherwise
    m=size(A,2);
    if (A(m)<=0) && (B(m)>0)%可行解支配不可行解
        dom_relation=1;
    end
    if (A(m)>0) && (B(m)<=0)%可行解支配不可行解
        dom_relation=2;
    end
    if (A(m)>0) && (B(m)>0)%都是不可行解
        if A(m)<B(m)
           dom_relation=1;
       else
           dom_relation=2;
       end
    end
    if (A(m)<=0) && (B(m)<=0)%都是可行解
        dom_relation=0;
        A1=A(1:size(A,2)-1);
        B1=B(1:size(B,2)-1);
        c1=sum(A1<B1);
        c2=sum(A1>B1); 
        if (c1>=0) && (c2==0)
            dom_relation=1;
        elseif (c1==0)&& (c2>0)
            dom_relation=2;
        end;
    end
%ght_modi 2013-6-15 rewrite
end

