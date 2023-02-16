# VoyagerGoldenDisk
## Intro:
### From wikipedia: 
> <i>The Voyager Golden Records are two phonograph records that were included aboard both Voyager spacecraft launched in 1977. The records contain sounds and images selected to portray the diversity of life and culture on Earth, and are intended for any intelligent extraterrestrial life form who may find them. The records are a time capsule.
    </i>
    
The given signal contains only the images (without sounds). The key to decoding it is understanding how the decoding of a monochrome television works. 
<br /> 
[Youtube video that helped me understand the decoding concept in momochrome TV]( https://www.youtube.com/watch?v=5yiJzNx6BCM&t=449s&ab_channel=EngineeringFunda)

<br /> 

[Another helpful blog on the Voyager decoding](https://boingboing.net/2017/09/05/how-to-decode-the-images-on-th.html)

## Workflow of my code:
Below is a flowchart describing the different functions in my code. In the flowchart are references to plots, which are shown after the flowchart, and are commented out in the code itself. 

```mermaid
%%{init: {'theme': 'base', 'themeVariables': { 'fontSize': '35px'}}}%%
flowchart TB



%% Nodes:

    id1[<b>Main:</b> <br /> <br /> 1. load mp3 file <br /> <br /> 2. separate mp3 file to channels]
    
    id2[<b>CreateImgFromSignal:</b> <br /> <br /> Find peaks that mark the beginning and end<br /> of each image in the signal.]
    
    id3[For every signal between two <br /> peaks of image signal:]
    
    id4{{<i>The start or end of image signal <br /> is noisy sometimes.<br /> <br />In these periods the spectrum <br /> of the signal has harmonics. <br /><br /> If the signal has more than 3 harmonics,<br /> I considered it noisy.</i>}}
    
    id5[<b>RemoveNoiseImgSignal:</b>  <br /> <br /> 1. Find noise at the beginning and end of every image signal <br /> <br /> 2. check that the code didnt detect too  much noise. <br /> <br />3. Remove noise from signal. ]
        
    id6[<b>FindNoisySignal:</b>  <br /> <br /> Peaks in the spectrum represent harmonics. <br />Iterate over a window the size of one trace + retrace<br /> until a signal with less than 3 harmonics is found.<br /> Count how many noisy windows were found.]
    
    id7[<b>FindPeaksInSpectrum:</b>  <br /> <br /> Create spectrum in signal using fft, and find peaks. <br />The peaks represent harmonics. If a signal has  harmonics,<br /> its considered noisy in the current problem.]
        
    id8[<b>FindpeaksTraceRetrace:</b> <br />  <br /> find peaks in image signal that<br />  representthe trace and retrace]
        
    id9[<b>AdjustmentsTracePeaks:</b> <br />  <br /> Adjust peaks in 3 steps: <br /> <br /> 1.	Throw an error if there is a significant <br />difference between max and minpeaks numbers. <br /> This means that the code didnt detect the right peaks <br /> because the signal is symmetric. <br /> <br /> 2.	Make peaks lengths equal. <br /> Removing elements from the longer locs array  <br />to create equal locs arrays for future loops. <br /> <br /> 3.	adjust peaks order of appearance:<br /> The first min is always before the first max.]
    
    id10[<b>CreateImgFromTrace:</b> <br />  <br /> 1. Iterate over the signal that<br /> represents an image to find the traces.<br /> 2. Create a matrix in which each row is a trace. <br /> <br /> 3. Create image from the matrix.]
    
    %% plot nodes:
   
    plt1((Plot 1)) 
    plt2((Plot 2)) 
    plt34((Plots 3,4)) 
    plt5((Plot 5)) 
    plt6((Plot 6)) 
    
    %% Relations between nodes: 
    
    id1--> id2 --> plt1 ---> id3
    id3 --- step1 --> id4  --> id5 --> plt2--> id6 --> id7 --> plt34
    id3---  step2--> id8 --> plt5
    id3---  step3--> id9
    id3---  step4--> id10 --> plt6 
    
    %% attaching to class for styling:
    
    class id1,id2,id5,id6,id7,id8,id9,id10 nodesfunc;
    class id3,id4 nodescomment;
    class plt1,plt2,plt34,plt5,plt6 nodesplt;
    
    %% styling:
    classDef default      fill:#F8CCDC
    classDef nodesfunc    fill:#A2DCE7, stroke:#333,stroke-width:4px
    classDef nodescomment fill:#FFED86, stroke:#333,stroke-width:4px
    classDef nodesplt     fill:#FFB067, stroke:#333,stroke-width:4px, color:#fff

```


![image](https://user-images.githubusercontent.com/79848589/217568369-394ed8f8-3813-4b18-94d0-7d7732bb1752.png)

Plot 1: Detect peaks that represent the beginning and end of the image

![image](https://user-images.githubusercontent.com/79848589/217568463-17b69115-d930-4e7a-a372-fcf55fd14dd4.png)

Plot 2: Remove noise from the image signal.

![image](https://user-images.githubusercontent.com/79848589/217568539-ac9a4304-7e3a-4321-9af3-60c17738ac36.png)

Plot 3: Spectrum of a noisy signal window

![image](https://user-images.githubusercontent.com/79848589/217568601-0db87eb1-8fe8-4638-a8be-6fd047439db1.png)

Plot 4: Spectrum of a good window

![image](https://user-images.githubusercontent.com/79848589/217568860-673ba044-4394-41d7-a136-1cb6b9cd552f.png)

![image](https://user-images.githubusercontent.com/79848589/217568960-3b2a1b6d-02eb-476e-be4d-8f818279c76e.png)
