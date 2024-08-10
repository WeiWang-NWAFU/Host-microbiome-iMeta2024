library(tidyverse)
library(RColorBrewer)
library(MetBrewer)
library(ggnewscale)

df <- read.csv("C:/Users/data.csv",header = TRUE) %>% 
  select(3,4,6) %>% 
  mutate(count=-log10(Pvalue)) %>% 
  arrange(desc(count)) %>% head(10)

df$Pathway <- factor(df$Pathway,levels = df$Pathway %>% unique() %>% rev())

df %>% 
  ggplot(aes(count,Pathway))+
  geom_segment(aes(x=0,xend=count,y=Pathway,yend=Pathway),
               size=8,show.legend = F, color = "#7DAEE0")+
  geom_text(aes(x=0,y=Pathway,label=Pathway), vjust=0.5,hjust=0,size=3,color="black")+
  geom_point(aes(size=df$out),shape=19, color="gray20",alpha=0.5) +
  guides(size=guide_legend(title="Gene count"))+
  labs(x = "-log10(pvalue)")+
  labs(y = "Enrichment terms")+
  theme_classic()+
  coord_cartesian(clip="off")+
  scale_x_continuous(expand = c(0,0.05))+
  
  theme(axis.text.y=element_blank(),
        axis.ticks.y=element_blank())
       
        
        

