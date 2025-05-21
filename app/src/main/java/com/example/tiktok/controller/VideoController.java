
package com.example.tiktok.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RestController
public class VideoController {

    @GetMapping("/videos")
    public List<String> getVideos() {
        return List.of("video1.mp4", "video2.mp4", "video3.mp4");
    }
}
