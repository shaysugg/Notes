[FFmpegKit](https://github.com/arthenica/ffmpeg-kit/tree/main/apple)
[FFmpeg official docs](https://ffmpeg.org/doxygen/7.0/index.html)
[# AVFoundation](https://developer.apple.com/documentation/avfoundation)


```c
#import <FFmpeg/avcodec.h>
#import <FFmpeg/avformat.h>
#import <FFmpeg/swscale.h>

// Open the video file
AVFormatContext* formatContext = NULL;
if (avformat_open_input(&formatContext, [videoFilePath UTF8String], NULL, NULL) != 0) {
    // Handle error
}

// Find the video stream
int videoStreamIndex = -1;
for (int i = 0; i < formatContext->nb_streams; i++) {
    if (formatContext->streams[i]->codec->codec_type == AVMEDIA_TYPE_VIDEO) {
        videoStreamIndex = i;
        break;
    }
}

// Initialize the video decoder
AVCodecContext* codecContext = formatContext->streams[videoStreamIndex]->codec;
AVCodec* codec = avcodec_find_decoder(codecContext->codec_id);
if (avcodec_open2(codecContext, codec, NULL) < 0) {
    // Handle error
}

// Decode and render video frames
while (true) {
    AVPacket packet;
    if (av_read_frame(formatContext, &packet) < 0) {
        // End of video
        break;
    }

    if (packet.stream_index == videoStreamIndex) {
        // Decode the video frame
        AVFrame* frame = av_frame_alloc();
        int frameFinished;
        avcodec_decode_video2(codecContext, frame, &frameFinished, &packet);

        if (frameFinished) {
            // Render the video frame
            // ...
        }

        av_frame_free(&frame);
    }

    av_free_packet(&packet);
}

// Clean up
avcodec_close(codecContext);
avformat_close_input(&formatContext);

```