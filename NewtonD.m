
function sys=NewtonD()
    clear,clc,close all 
    num=50;%最大迭代次数
    eps=1e-9; %迭代精度
    X=zeros(num,5);
    X(1,:)=[100, 100 ,50,50,-1]; %初始解
tic
    flag=0;
    for k=1:num-1
        syms  x1 x2 x3 x4 x5
        
        f=fx( x1, x2 ,x3 ,x4, x5 );
        f=subs(f,{x1,x2,x3,x4,x5},{X(k,1),X(k,2),X(k,3),X(k,4),X(k,5)});
        
        df=Jacobi(x1, x2 ,x3 ,x4 ,x5);
        df=subs(df,{x1,x2,x3,x4,x5},{X(k,1),X(k,2), X(k,3),X(k,4),X(k,5)});
        X(k+1,:)=X(k,: ) - ( df \ f')';
        if( abs( X(k+1,1)-X(k,1) )<eps && abs( X(k+1,2)-X(k,2) )<eps && abs( X(k+1,3)-X(k,3) )<eps)
            flag=1;
            sys=vpa(  X(1:k+1,:) ,7);
            Error=fx( X(k+1,1), X(k+1,2) ,X(k+1,3),X(k+1,4),X(k+1,5)) ;
            figure(1)
            plot(Error)
            figure(2)
            plot(sys(:,1), '-+' , 'linewidth',3)
            hold on
            plot(sys(:,2), '--' , 'linewidth',3)
            hold on
            plot(sys(:,3), '-*' , 'linewidth',3)
            hold on
            plot(sys(:,4), '-s' , 'linewidth',3)
            hold on
            plot(sys(:,5), '-v' , 'linewidth',3)
            grid on 
            legend('x1','x2','x3','x4','x5')
            title('Newton iteration method for nonlinear equations')
            
            break;
        end
    toc        
    end
    
    if(~flag)
        sys=[];
        disp('Iterative Failure!')
    end

end
 
function sys=Jacobi(x1, x2,x3,x4,x5)
    f=fx( x1, x2 ,x3,x4,x5);
    sys=jacobian([f(1) f(2) f(3) f(4) f(5)],[x1 x2 x3 x4 x5]);
    
end

function sys=fx( x1, x2,x3,x4,x5 )
    sys(1)=x1 + x4 - 400*sin(pi/4);
    sys(2)=x2 - x3 - 400*sin(pi/4);
    sys(3)=x3 + x4 - 120;
    sys(4)=x4 - x5*x2;
    sys(5)=x3 - x5*x1;
end

