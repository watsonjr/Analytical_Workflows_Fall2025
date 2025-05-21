###########################################################
### How simple neural networks learn complex functions ### 
###########################################################
install.packages("manipulate","ggplot2")
yes

library(manipulate)
library(ggplot2)

# Plots the value of a single neuron as a function of a single input 
# x. clicking the gear in the top right wil allow you to manipulate 
# the weights and bias of the neuron to see how that effects its value
nn <- function(x,w1,b1){return(tanh(w1*x+b1))}
x_ <- seq(-4,4,0.01)
manipulate(
  plot(x_, nn(x_,w1,b1),ylim = c(-5, 5), type =  "l"),
  w1 = slider(-3, 3, step=0.01, initial = 1),
  b1 = slider(-3, 3, step=0.01, initial = 0.0)
)





# Plot a neural network with one input, three hidden units, and one output.  
# This plot allows the weights and biases of the final output neuron to be adjusted. 
# The parameters can be adjusted to match the neural network outputs to the data
# The plot title shoes the mean squared error between the data and the neural network.   
# Click the gear in the top left of the plot to manipulate the parameters
x_sample <- 8*(runif(length(x_))-0.5)
e_sample <- 0.25*rnorm(length(x_))
y_ <- sin(1.25*x_sample)+e_sample
neuron_1 <- function(x){nn(x,1.5,4.0)}
neuron_2 <- function(x){nn(x,1.5,0.0)}
neuron_3 <- function(x){nn(x,1.5,-4.0)}
nn_2 <- function(x,w1,w2,w3,b){b+w1*neuron_1(x)+w2*neuron_2(x)+w3*neuron_3(x)}
plt_function <- function(w1,w2,w3,b){
  y_hat=c(nn_2(x_,w1,w2,w3,b),w1*neuron_1(x_),w2*neuron_2(x_),w3*neuron_3(x_))
  groups = c(rep("Neural network", length(x_)), rep("Neuron 1", length(x_)),
             rep("Neuron 2", length(x_)),rep("Neuron 3", length(x_)))
  dat <- data.frame(x=rep(x_,4),y=y_hat,group = groups )
  MSE <- mean((nn_2(x_sample,w1,w2,w3,b) - y_)^2)
  
  ggplot(dat,aes(x=x,y,y, color = group, alpha= group))+
    geom_line(linewidth = 1)+ ylim(-4,4)+theme_classic()+
    scale_color_manual(values = c("grey","black", "purple", "blue", "green"))+
    scale_alpha_manual(values = c(0.75,1.0, 0.5, 0.5, 0.5))+
    ylab("Neural network output")+xlab("Input (X)")+
    geom_point(data=data.frame(x = x_sample, y = y_,color = "black", group = "data"))+
    ggtitle(paste("Loss = ", MSE))
}

manipulate(
  plt_function(w1,w2,w3,b),
  w1 = slider(-1.5, 1.5, step=0.01, initial = 1),
  w2 = slider(-1.5, 1.5, step=0.01, initial = 1.0),
  w3 = slider(-1.5, 1.5, step=0.01, initial = 1),
  b = slider(-15, 1.5, step=0.01, initial = 0.0)
)




# Plot a neural network with one input, three hidden units, and one output.  
# This plot allows the weights and biases of the final output neuron to be adjusted. 
# The parameters can be adjusted to match the neural network outputs to the data
# The plot title shoes the mean squared error between the data and the neural network.   
# Click the gear in the top left of the plot to manipulate the parameters
x_sample <- 8*(runif(length(x_))-0.5)
e_sample <- 0.25*rnorm(length(x_))
y_ <- sin(1.25*exp(0.5*x_sample))+e_sample
nn_2 <- function(x,w1,w2,w3,b,b1,b2,b3){b+w1*nn(x,0.5,b1)+w2*nn(x,1.5,b2)+w3*nn(x,1.5,b3)}
plt_function <- function(w1,w2,w3,b,b1,b2,b3){
  y_hat=c(nn_2(x_,w1,w2,w3,b,b1,b2,b3),w1*nn(x_,0.5,b1),w2*nn(x_,1.5,b2),w3*nn(x_,1.5,b3))
  groups = c(rep("Neural network", length(x_)), rep("Neuron 1", length(x_)),
             rep("Neuron 2", length(x_)),rep("Neuron 3", length(x_)))
  dat <- data.frame(x=rep(x_,4),y=y_hat,group = groups )
  MSE <- mean((nn_2(x_sample,w1,w2,w3,b,b1,b2,b3) - y_)^2)
  
  ggplot(dat,aes(x=x,y,y, color = group, alpha= group))+
    geom_line(linewidth = 1)+ ylim(-4,4)+theme_classic()+
    scale_color_manual(values = c("grey","black", "purple", "blue", "green"))+
    scale_alpha_manual(values = c(0.75,1.0, 0.5, 0.5, 0.5))+
    ylab("Neural network output")+xlab("Input (X)")+
    geom_point(data=data.frame(x = x_sample, y = y_,color = "black", group = "data"))+
    ggtitle(paste("Loss = ", MSE))
}

manipulate(
  plt_function(w1,w2,w3,b,b1,b2,b3),
  w1 = slider(-1.5, 1.5, step=0.01, initial = 1),
  w2 = slider(-1.5, 1.5, step=0.01, initial = 1.0),
  w3 = slider(-1.5, 1.5, step=0.01, initial = 1),
  b = slider(-2.5, 2.5, step=0.01, initial = 0.0),
  b1 = slider(-5.5, 5.5, step=0.01, initial = 0.0),
  b2 = slider(-5.5, 5.5, step=0.01, initial = 0.0),
  b3 = slider(-5.5, 5.5, step=0.01, initial = 0.0)
)









###################
### Extra plots ###
###################

# Plot a neural network with one input, three hidden units, and one output.  
# This plot allows the weights and biases of the final output neuron to be adjusted.
# The gradient of the loss function with respect to the 4 parameters in the output layer
# is printed in the plot title. To see (roughly) how the gradient descent algorithm trains
# a neural network, adjust the parameter with the largest gradient up if the gradient is positive
# and down if the gradient is negative. Repeat this step several times, notice how the predictions
# change as you continue to adjust the parameters of the model. 
# The plot title shows the mean squared error between the data and the neural network.   
# Click the gear in the top left of the plot to manipulate the parameters
x_sample <- 8*(runif(length(x_))-0.5)
e_sample <- 0.25*rnorm(length(x_))
y_ <- sin(1.25*x_sample)+e_sample
neuron_1 <- function(x){nn(x,1.5,4.0)}
neuron_2 <- function(x){nn(x,1.5,0.0)}
neuron_3 <- function(x){nn(x,1.5,-4.0)}
grad <- function(y_,x_,w1,w2,w3,b){
  # A very simple function for calculating gradients using first differences
  MSE <- mean((nn_2(x_,w1,w2,w3,b) - y_)^2)
  MSE_w1 <- (mean((nn_2(x_,w1+0.01,w2,w3,b) - y_)^2)-MSE)/0.01
  MSE_w2 <- (mean((nn_2(x_,w1,w2+0.01,w3,b) - y_)^2)-MSE)/0.01
  MSE_w3 <- (mean((nn_2(x_,w1,w2,w3+0.01,b) - y_)^2)-MSE)/0.01
  MSE_b <- (mean((nn_2(x_,w1,w2,w3,b+0.01) - y_)^2)-MSE)/0.01
  return(-1*round(c(MSE_w1,MSE_w2,MSE_w3,MSE_b),2))
}

plt_function <- function(w1,w2,w3,b){
  y_hat=c(nn_2(x_,w1,w2,w3,b),w1*neuron_1(x_),w2*neuron_2(x_),w3*neuron_3(x_))
  groups = c(rep("Neural network", length(x_)), rep("Neuron 1", length(x_)),
             rep("Neuron 2", length(x_)),rep("Neuron 3", length(x_)))
  dat <- data.frame(x=rep(x_,4),y=y_hat,group = groups )
  MSE <- mean((nn_2(x_sample,w1,w2,w3,b) - y_)^2)
  grads <- grad(y_,x_sample,w1,w2,w3,b)
  ggplot(dat,aes(x=x,y=y, color = group, alpha= group))+
    geom_line(linewidth = 1)+ ylim(-4,4)+theme_classic()+
    scale_color_manual(values = c("grey","black", "purple", "blue", "green"))+
    scale_alpha_manual(values = c(0.75,1.0, 0.5, 0.5, 0.5))+
    ylab("Neural network output")+xlab("Input (X)")+
    geom_point(data=data.frame(x = x_sample, y = y_,color = "black", group = "data"))+
    ggtitle(paste("Loss = ", MSE, "\n Gradients:  w1 = " ,grads[1], " w2 = ", grads[2],
                  " w3 = ", grads[3],"b = ",grads[4]))
}
manipulate(
  plt_function(w1,w2,w3,b),
  w1 = slider(-1.5, 1.5, step=0.01, initial = 1),
  w2 = slider(-1.5, 1.5, step=0.01, initial = 1.0),
  w3 = slider(-1.5, 1.5, step=0.01, initial = 1),
  b = slider(-15, 1.5, step=0.01, initial = 0.0)
)

make_plot <- function(b,w1,w2){
df <- as.data.frame(expand.grid(x = seq(-4,4,0.5),y = seq(-4,4,0.5)))
df$neuron <- tanh(b+w1*df$x+w2*df$y)

ggplot(df,aes(x=x,y=y, fill = neuron))+
  geom_tile()+theme_classic()+
  viridis::scale_fill_viridis()+
  theme(legend.position = "none")
}

manipulate(
  make_plot(b,w1,w2),
  w1 = slider(-1.5, 1.5, step=0.01, initial = 1),
  w2 = slider(-1.5, 1.5, step=0.01, initial = 1.0),
  b = slider(-1.5, 1.5, step=0.01, initial = 0.0)
)





### More neurons can capture more complex functions  
x_sample <- 8*(runif(length(x_))-0.5)
e_sample <- 0.25*rnorm(length(x_))
y_ <- 0.25*x_sample^2+e_sample
neuron_1 <- function(x){nn(x,1.5,5.0)}
neuron_2 <- function(x){nn(x,1.5,2.5)}
neuron_3 <- function(x){nn(x,1.5,0.0)}
neuron_4 <- function(x){nn(x,1.5,-2.5)}
neuron_5 <- function(x){nn(x,1.5,-5.0)}
nn_3 <- function(x,w1,w2,w3,w4,w5,b){
  b+w1*neuron_1(x)+w2*neuron_2(x)+w3*neuron_3(x)+w4*neuron_4(x)+w5*neuron_5(x)
}
plt_function <- function(w1,w2,w3,w4,w5,b){
  y_hat=c(nn_3(x_,w1,w2,w3,w4,w5,b),w1*neuron_1(x_),w2*neuron_2(x_),w3*neuron_3(x_),w4*neuron_4(x_),w5*neuron_5(x_))
  groups = c(rep("Neural network", length(x_)), rep("Neuron 1", length(x_)),
             rep("Neuron 2", length(x_)),rep("Neuron 3", length(x_)),
             rep("Neuron 4", length(x_)),rep("Neuron 5", length(x_)))
  dat <- data.frame(x=rep(x_,6),y=y_hat,group = groups )
  MSE <- mean((nn_3(x_sample,w1,w2,w3,w4,w5,b) - y_)^2)
  
  ggplot(dat,aes(x=x,y,y, color = group, alpha= group))+
    geom_line(linewidth = 1)+ ylim(-2,6)+theme_classic()+
    scale_color_manual(values = c("grey","black", "purple", "blue","darkgreen" ,"green", "yellow"))+
    scale_alpha_manual(values = c(0.75,1.0, 0.5, 0.5, 0.5,0.5,0.5))+
    ylab("Neural network output")+xlab("Input (X)")+
    geom_point(data=data.frame(x = x_sample, y = y_,color = "black", group = "data"))+
    ggtitle(paste("Loss = ", MSE))
}

manipulate(
  plt_function(w1,w2,w3,w4,w5,b),
  w1 = slider(-2.5, 2.5, step=0.01, initial = 1),
  w2 = slider(-2.5, 2.5, step=0.01, initial = 1.0),
  w3 = slider(-2.5, 2.5, step=0.01, initial = 1),
  w4 = slider(-2.5, 2.5, step=0.01, initial = 1),
  w5 = slider(-2.5, 2.5, step=0.01, initial = 1),
  b = slider(-6.0, 6.0, step=0.01, initial = 0.0)
)

