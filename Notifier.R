# BUILDING GRAPHS

  # Time span graphic
beg_down <- as.POSIXct(beg_down)
end_down <- as.POSIXct(end_down)
midnight <- as.POSIXct(paste(Sys.Date(), 00:00:00))

ggplot(data.frame(marche), aes(x=marche)) +
  geom_linerange(aes(ymin=beg_down,ymax=end_down),linetype=2,color="blue") +
  geom_point(aes(y=beg_down),size=3,color="red") +
  geom_point(aes(y=end_down),size=3,color="red") +
  theme_bw() +
  xlab("") +
  ylab("") +
  scale_y_datetime(date_breaks = "2 hours" , date_labels = "%H:%M") +
  geom_hline(yintercept = midnight, size=.5) +
  theme(axis.text.x = element_text(face="bold"))
ggsave(filename = "Span.png",
       path = "./Graphs",
       width = 5,
       height = 3)

# Barplot number of tweet downloaded
ggplot(data.frame(count_down),
       aes(x = count_down,
           y = reorder(marche,-count_down),
           fill = count_down)) +
  guides(fill = "none") +
  geom_bar(stat = "identity") +
  xlab("") +
  ylab("") +
  theme_minimal()+
  xlim(0, 6500) +
  theme(axis.text.y = element_text(face="bold")) +
  geom_text(
    aes(label = count_down), 
    hjust = -.1, nudge_x = +.5,
    size = 4, fontface = "bold",
    fill = "white", label.size = 0
  )
ggsave(filename = "downloaded.png",
       path = "./Graphs",
       width = 6,
       height = 4,
       bg = "white")



# SEND EMAIL
# Scrivo il testo
rawHTML <- paste(readLines("./MailHtml.html", warn = F), collapse = "\n")

gm_auth_configure(path = **insert your gmail API credentials here**)
subject <- paste("Report", Sys.Date())
message <- gm_mime() %>%
  gm_to("yourmail@mail.com") %>%
  gm_from("yourmail2@mail.com") %>%
  gm_subject(subject) %>%
  gm_html_body(rawHTML) %>%
  gm_attach_file("./Graphs/downloaded.png", id = "downloaded") %>%
  gm_attach_file("./Graphs/Span.png", id = "span")
  
gm_send_message(message)
1
