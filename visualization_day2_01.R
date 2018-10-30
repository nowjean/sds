df = data.frame(xx = 1:10,
                yy = 1:10)

ggplot(data = df,
       aes(x = xx, y = yy)) + 
  geom_hline(yintercept = 3, size = 2,
             color = "red", alpha = 0.3) +
  geom_line(size = 1.5) + 
  geom_point(size = 8) + 
  geom_point(size = 6,
             color = "#FFFFFF") + 
  geom_text(aes(label = LETTERS[1:10]),
            fontface = "bold") + 
  annotate(geom = "text", x = 9.8, y = 3.4,
           label = "limit") + 
  labs(title = "Sample", 
       x = "x axis", y = "y axis") + 
  theme_bw() + 
  theme(plot.title = element_text(hjust = 0.5,
                                  face = "bold",
                                  size = 20))
