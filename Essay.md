# Features and technology
With the development of technology and the economy, people’s living conditions are improving. However, there are still some people who live in rural areas that are left behind in this trend. To eliminate the gap between the rich and the poor, many means are tried by the government to help the poor get out of poverty. However, the public still lacks attention and care for those living in undeveloped areas. With personal experience and knowledge in addition to celebrating China’s complete alleviation of poverty, I created MayISolveThis(MIST), a Swift Playground targeted to help children develop coding skills in an interesting way and gain knowledge about the common ways of getting rid of poverty at the same time.

In this playground, you will be helping villagers by placing down given facilities. Each facility has an “affection range” and has different impacts on people’s happiness and the environment. Your task is to help everyone reach their life goal. This playground consists of three chapters. The first chapter, “Introduction”, contains 2 pages and will teach you the basics and construction of MIST. Detailed controls are written on the playground page. 40 seconds to one minute is required for this chapter depending on the reading speed. The second chapter, “Helping Yourself”, contains 2 pages. In this chapter, you are encouraged to perform minor changes to the code and learn about real-life skills used in alleviating poverty. 1 minute and probably a half is needed. The third chapter, “Creating Your Own”, contains a sandbox and an extra pre-built scene. Drawn inspiration from Learn to Code 3, the sandbox allows you to show your creativity and explore as well. The extra scene(optional), built on top of the real story of Shibadong Village, showcases the potentials of the playground. It also provides a relatively realistic challenge for you to test your problem-solving skill. You will spend about 1 minute here.

This Swift Playground is built using both SwiftUI and SpriteKit. SpriteKit provides me with the flexibility to carry out complex operations. So the main scene and the item selection bar are both powered by SpriteKit. This also enables me to implement item dropping and selecting fairly easily. SwiftUI, on the other hand, offers an elegant UI system and various handy components. Thus, SwiftUI is used to display extra information and glue all parts together to create a harmonized view. By combining SwiftUI and SpriteKit, I can benefit from both sides and create a scene that is not only good to look at but is also fun to play. To transfer object data and play animation properly, a central data structure is used to string up the main scene(SpriteKit) and the UI components(SwiftUI). The playground also follows a modular design to support an easy-to-write sandbox.

Following the spirit of educational Apple playgrounds, I hope this little work can motivate the children to learn to code while teaching them to love and care about other people around the globe.

# Beyond WWDC
Besides this project, I have also explored other aspects of programming, including game development, web building, competitive programming, and so on.

I have been learning competitive programming (CP in short, aka Olympics Informatics) since 3rd grade. I took part in National Olympiad in Informatics in Provinces(NOIP) - a national competition in China - and got first prize for Senior group in Junior two. After winning the prize, I proposed problems for “August Easy ’19” and “Data Structures and Algorithms coding challenge Aug ’19” for an international competitive programming website HackerEarth. It took me over a month to prepare the solution, data and editorial. Over 3000 users took part in the contests online. After the contest, the competitors shared their approaches and I showed mine. By discussing and comparing different ideas and solutions, we all benefited and improved our CP skills from such an experience.

I also started some projects with my classmates. At school, I founded a “Development Club” in our school with my friends. I set up a course to teach members and other students basic programming skills and gaming developing patterns. What’s more, I set up a step-by-step tutorial on Java and Swift. There were a total of 8 lessons in each course and 1 hour for each lesson. By teaching other students, I figured what used to be ambiguous to me while my students also learned the essential skills to become an independent developer, like reading Docs and searching Stackoverflow. 

I also created a series of online judges(i.e. websites to test your program’s correctness) with one of the club members in Java. It’s called HHSOJ and the latest version is titled “HHSOJ Essential(Maven Edition)”. In development, this project has a SLOC of 3093 and was developed for over a year. It was used as a training center before the entrance exam to senior school. With 5 training contests, over 20 problems all by myself, and a total of 800 submissions from different examinees, this online judge gained great popularity in the club. And we were happy to see the result of the final entrance exam too: everyone who participated was accepted by some of the most popular senior highs in the city! Who would have thought that a simple system design testing project would turn out to be a featured project in the whole club?

Besides those, I also write tools, scripts, and games regularly. I created a simple Python script to help generate English problems for exam preparation last December. I took part in Ludum Dare 47 last October with the project “The Lost Forest”. If you are interested in my other works, you may pay a visit to my Github account: XiaoGeNintendo.

# Comments
The project can actually be used with gyroscope. Initially, my project was developed with a special feature called “Center Pinning”. Utlizing this feature, you can move the center of the town by tilting your iPad or iPhone. The distance between a person and the center will influence the efficiency of the facilities you place. It was completely finished and written in the code, even in the version you see. It is to simulate terrain changes. However, as the project was designed for and tested on macOS, it was excluded in the final version.