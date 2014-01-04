
cdef extern from "stdarg.h":
    ctypedef struct va_list:
        pass
from libc.stdint cimport int64_t, uint64_t, int32_t, uint32_t, uint16_t,\
int16_t, uint8_t, int8_t, uintptr_t

ctypedef int (*lockmgr_func)(void **, AVLockOp)
ctypedef int (*int_void_func)(void *) except? 1

ctypedef float FFTSample

include "ff_defs_comp.pxi"
include "sdl.pxi"


cdef:
    extern from * nogil:
        struct AVPacket:
            uint8_t *data
            int64_t pos
            int64_t pts
            int64_t dts
            int size
            int stream_index
            int flags
        enum AVMediaType:
            AVMEDIA_TYPE_UNKNOWN = -1,  #///< Usually treated as AVMEDIA_TYPE_DATA
            AVMEDIA_TYPE_VIDEO,
            AVMEDIA_TYPE_AUDIO,
            AVMEDIA_TYPE_DATA,          #///< Opaque data information usually continuous
            AVMEDIA_TYPE_SUBTITLE,
            AVMEDIA_TYPE_ATTACHMENT,    #///< Opaque data information usually sparse
            AVMEDIA_TYPE_NB,

    extern from "libavformat/avio.h" nogil:
        int AVIO_FLAG_WRITE
        int avio_check(const char *, int)
        int avio_open2(AVIOContext **, const char *, int, const AVIOInterruptCB *,
                       AVDictionary **)
        int avio_close(AVIOContext *)
        struct AVIOContext:
            int error
            int eof_reached
        struct AVIOInterruptCB:
            int (*callback)(void*)
            void *opaque
        int url_feof(AVIOContext *)
        inline int64_t avio_tell(AVIOContext *)

    extern from "libavutil/avstring.h" nogil:
         size_t av_strlcpy(char *, const char *, size_t)
         size_t av_strlcatf(char *, size_t, const char *, ...)
         char *av_asprintf(const char *, ...)

    extern from "libavutil/mathematics.h" nogil:
        int64_t av_rescale_q(int64_t, AVRational, AVRational)

    extern from "libavutil/pixdesc.h" nogil:
        struct AVPixFmtDescriptor:
            const char *name
            uint8_t nb_components
        const char *av_get_pix_fmt_name(AVPixelFormat)
        AVPixelFormat av_get_pix_fmt(const char *)
        const AVPixFmtDescriptor *av_pix_fmt_desc_next(const AVPixFmtDescriptor *)
        AVPixelFormat av_pix_fmt_desc_get_id(const AVPixFmtDescriptor *)
        const AVPixFmtDescriptor *av_pix_fmt_desc_get(AVPixelFormat)

    extern from "libavutil/imgutils.h" nogil:
        int av_image_alloc(uint8_t **, int *, int, int, AVPixelFormat, int)
        int av_image_fill_linesizes(int *, AVPixelFormat, int)

    extern from "libavutil/dict.h" nogil:
        int AV_DICT_IGNORE_SUFFIX
        int AV_DICT_DONT_STRDUP_VAL
        struct AVDictionaryEntry:
            char *key
            char *value
        void av_dict_free(AVDictionary **)
        AVDictionaryEntry * av_dict_get(AVDictionary *, const char *,
                                        const AVDictionaryEntry *, int)

    extern from "libavutil/parseutils.h" nogil:
        pass

    extern from "libavutil/samplefmt.h" nogil:
        enum AVSampleFormat:
            AV_SAMPLE_FMT_S16,
            AV_SAMPLE_FMT_NONE,
        AVSampleFormat av_get_packed_sample_fmt(AVSampleFormat)
        const char *av_get_sample_fmt_name(AVSampleFormat)
        int av_samples_get_buffer_size(int *, int, int, AVSampleFormat, int)
        int av_get_bytes_per_sample(AVSampleFormat)

    extern from "libavutil/avassert.h" nogil:
        pass

    extern from "libavutil/time.h" nogil:
        int64_t av_gettime()
        int av_usleep(unsigned)

    extern from * nogil:
        void av_free(void *)
        void av_freep(void *)
        void *av_malloc(size_t)
        char *av_strdup(const char *)
        int av_get_channel_layout_nb_channels(uint64_t)
        void av_get_channel_layout_string(char *, int, int, uint64_t)
        int64_t av_get_default_channel_layout(int)
        int av_clip(int a, int amin, int amax)
        int64_t AV_CH_LAYOUT_STEREO_DOWNMIX

        struct AVRational:
            int num #///< numerator
            int den #///< denominator
        inline double av_q2d(AVRational)
        int av_find_nearest_q_idx(AVRational, const AVRational*)

        int AV_LOG_QUIET
        int AV_LOG_PANIC
        int AV_LOG_FATAL
        int AV_LOG_ERROR
        int AV_LOG_WARNING
        int AV_LOG_INFO
        int AV_LOG_VERBOSE
        int AV_LOG_DEBUG
        int AV_LOG_SKIP_REPEATED
        void av_log(void *, int, const char *, ...)
        void av_log_set_flags(int)
        void av_log_set_level(int)
        void av_log_set_callback(void (*)(void*, int, const char*, va_list))
        void av_log_default_callback(void*, int, const char*, va_list)
        void av_log_format_line(void *, int, const char *, va_list, char *, int, int *)

        enum AVPixelFormat:
            AV_PIX_FMT_YUV420P,
            AV_PIX_FMT_RGB24,
            AV_PIX_FMT_NONE,

        int64_t AV_NOPTS_VALUE

        struct AVDictionary:
            pass
        int av_dict_set(AVDictionary **, const char *, const char *, int)

        void av_max_alloc(size_t)

        int av_get_cpu_flags()
        int av_parse_cpu_caps(unsigned *, const char *)
        void av_force_cpu_flags(int)
        void *av_mallocz(size_t)

        int AVERROR(int)
        int AVUNERROR(int)

        enum AVPictureType:
            AV_PICTURE_TYPE_NONE
        char av_get_picture_type_char(AVPictureType)
        void av_frame_unref(AVFrame *)
        void av_frame_free(AVFrame **)
        void av_frame_move_ref(AVFrame *, AVFrame *)
        AVFrame* av_frame_clone(const AVFrame *)
        unsigned av_int_list_length_for_size(unsigned, const void *, uint64_t)
        int av_opt_set_bin(void *, const char *, const uint8_t *, int, int)

        AVFrame *av_frame_alloc()
        int64_t av_frame_get_pkt_pos(const AVFrame *)
        int av_frame_get_channels(const AVFrame *)

        int AVERROR_EOF
        int AVERROR_OPTION_NOT_FOUND
        int av_strerror(int, char *, size_t)

        inline void *av_x_if_null(const void *p, const void *x)

        int64_t AV_TIME_BASE

        struct AVClass:
            pass

    extern from "libavformat/avformat.h" nogil:
        int AVSEEK_FLAG_BYTE
        int AVFMT_NOBINSEARCH
        int AVFMT_NOGENSEARCH
        int AVFMT_NO_BYTE_SEEK
        int AVFMT_FLAG_GENPTS
        int AVFMT_TS_DISCONT
        int AV_DISPOSITION_ATTACHED_PIC
        int AVFMT_GLOBALHEADER
        int AVFMT_VARIABLE_FPS
        int AVFMT_NOTIMESTAMPS
        int AVFMT_NOFILE
        int AVFMT_RAWPICTURE
        struct AVInputFormat:
            int (*read_seek)(AVFormatContext *, int, int64_t, int)
            int flags
            const char *name
        struct AVOutputFormat:
            const char *name
            int flags
        struct AVFormatContext:
            AVInputFormat *iformat
            AVOutputFormat *oformat
            AVStream **streams
            unsigned int nb_streams
            char filename[1024]
            AVIOContext *pb
            AVDictionary *metadata
            AVIOInterruptCB interrupt_callback
            int flags
            int64_t start_time
            int bit_rate
            int64_t duration
        struct AVStream:
            int index
            AVCodecContext *codec
            AVRational time_base
            int64_t start_time
            AVDiscard discard
            AVPacket attached_pic
            int disposition
            AVRational avg_frame_rate
            AVRational r_frame_rate
            AVDictionary *metadata
        struct AVProgram:
            unsigned int nb_stream_indexes
            unsigned int *stream_index
        void av_register_all()
        int avformat_network_init()
        int avformat_network_deinit()
        AVInputFormat *av_find_input_format(const char *)
        AVRational av_guess_sample_aspect_ratio(AVFormatContext *, AVStream *, AVFrame *)
        AVRational av_guess_frame_rate(AVFormatContext *, AVStream *, AVFrame *)
        int avformat_match_stream_specifier(AVFormatContext *, AVStream *,
                                            const char *)
        AVFormatContext *avformat_alloc_context()
        int avformat_open_input(AVFormatContext **, const char *, AVInputFormat *, AVDictionary **) with gil
        void avformat_close_input(AVFormatContext **)
        int avformat_find_stream_info(AVFormatContext *, AVDictionary **) with gil
        int avformat_seek_file(AVFormatContext *, int, int64_t, int64_t, int64_t, int)
        int av_find_best_stream(AVFormatContext *, AVMediaType, int, int, AVCodec **, int)
        void av_dump_format(AVFormatContext *, int, const char *, int)
        int av_read_pause(AVFormatContext *)
        int av_read_play(AVFormatContext *)
        int av_read_frame(AVFormatContext *, AVPacket *) with gil
        AVProgram *av_find_program_from_stream(AVFormatContext *, AVProgram *, int)
        int avformat_write_header(AVFormatContext *, AVDictionary **)
        int av_write_trailer(AVFormatContext *)
        int avformat_alloc_output_context2(AVFormatContext **, AVOutputFormat *,
                                           const char *, const char *)
        AVStream *avformat_new_stream(AVFormatContext *, const AVCodec *)
        int av_interleaved_write_frame(AVFormatContext *, AVPacket *)
        void avformat_free_context(AVFormatContext *)
        AVOutputFormat *av_oformat_next(AVOutputFormat *)
        AVInputFormat *av_iformat_next(AVInputFormat  *)
    extern from "libavdevice/avdevice.h" nogil:
        void avdevice_register_all()

    extern from "libswscale/swscale.h" nogil:
        int SWS_BICUBIC
        struct SwsContext:
            pass
        struct SwsFilter:
            pass
        SwsContext *sws_getContext(int, int, AVPixelFormat, int, int, AVPixelFormat,
                                   int, SwsFilter *, SwsFilter *, const double *)
        SwsContext *sws_getCachedContext(SwsContext *, int, int, AVPixelFormat,
                                        int, int, AVPixelFormat, int, SwsFilter *,
                                        SwsFilter *, const double *)
        int sws_scale(SwsContext *, const uint8_t *const [], const int[], int, int,
                      uint8_t *const [], const int[])
        void sws_freeContext(SwsContext *)

    extern from "libavutil/opt.h" nogil:
        int AV_OPT_SEARCH_CHILDREN
        int AV_OPT_FLAG_ENCODING_PARAM
        int AV_OPT_FLAG_DECODING_PARAM
        int AV_OPT_FLAG_VIDEO_PARAM
        int AV_OPT_FLAG_AUDIO_PARAM
        int AV_OPT_FLAG_SUBTITLE_PARAM
        int AV_OPT_SEARCH_FAKE_OBJ
        struct AVOption:
            pass
        int av_opt_get_int(void *, const char *, int, int64_t *)
        int av_opt_set_int(void *, const char *, int64_t, int)
        int av_opt_set_image_size(void *, const char *, int, int, int)
        int av_opt_set (void *, const char *, const char *, int)
        const AVOption *av_opt_find(void *, const char *, const char *, int, int)

    extern from "libavcodec/avfft.h" nogil:
        enum RDFTransformType:
            DFT_R2C,
            IDFT_C2R,
            IDFT_R2C,
            DFT_C2R,
        struct RDFTContext:
            pass
        void av_rdft_end(RDFTContext *)
        RDFTContext *av_rdft_init(int, RDFTransformType)
        void av_rdft_calc(RDFTContext *, FFTSample *)

    extern from "libswresample/swresample.h" nogil:
        struct SwrContext:
            pass
        void swr_free(SwrContext **)
        SwrContext *swr_alloc_set_opts(SwrContext *, int64_t, AVSampleFormat,
                                       int, int64_t, AVSampleFormat, int, int, void *)
        int swr_init(SwrContext *)
        int swr_set_compensation(SwrContext *, int, int)
        int swr_convert(SwrContext *, uint8_t **, int, const uint8_t ** , int)

    #if CONFIG_AVFILTER
    extern from "libavfilter/avcodec.h" nogil:
        int CODEC_FLAG_EMU_EDGE
        int CODEC_FLAG2_FAST
        int CODEC_CAP_DR1
        int CODEC_FLAG_GLOBAL_HEADER
        int AV_PKT_FLAG_KEY
        int CODEC_CAP_DELAY
        struct AVCodec:
            const char *name
            int capabilities
            const AVClass *priv_class
            AVCodecID id
            uint8_t max_lowres
            const AVRational *supported_framerates
            const AVPixelFormat *pix_fmts
            AVMediaType type
        struct AVCodecContext:
            int width
            int height
            int64_t pts_correction_num_faulty_pts  # Number of incorrect PTS values so far
            int64_t pts_correction_num_faulty_dts  # Number of incorrect DTS values so far
            AVRational sample_aspect_ratio
            AVRational time_base
            const AVCodec *codec
            AVCodecID codec_id
            AVMediaType codec_type
            int workaround_bugs
            int lowres
            int error_concealment
            int flags
            int flags2
            int sample_rate
            int channels
            uint64_t channel_layout
            AVSampleFormat sample_fmt
            AVPixelFormat pix_fmt
            AVFrame *coded_frame
            int me_threshold
        struct AVSubtitle:
            uint16_t format
            uint32_t start_display_time # relative to packet pts, in ms
            uint32_t end_display_time   # relative to packet pts, in ms
            unsigned num_rects
            AVSubtitleRect **rects
            int64_t pts
        struct AVFrame:
            int top_field_first
            int interlaced_frame
            AVPictureType pict_type
            AVRational sample_aspect_ratio
            int width, height
            int format
            int64_t pts
            int64_t pkt_pts
            int64_t pkt_dts
            int sample_rate
            int nb_samples
            uint64_t channel_layout
            uint8_t **extended_data
            uint8_t **data
            int *linesize
        struct AVPicture:
            uint8_t **data
            int *linesize
        struct AVSubtitleRect:
            int x         #///< top left corner  of pict, undefined when pict is not set
            int y         #///< top left corner  of pict, undefined when pict is not set
            int w         #///< width            of pict, undefined when pict is not set
            int h         #///< height           of pict, undefined when pict is not set
            AVPicture pict
            int nb_colors
            char *text
            char *ass
            AVSubtitleType type
        enum AVSubtitleType:
            SUBTITLE_NONE
            SUBTITLE_BITMAP
            SUBTITLE_TEXT
            SUBTITLE_ASS
        int64_t av_frame_get_best_effort_timestamp(const AVFrame *)
        int av_codec_get_max_lowres(const AVCodec *)
        void av_codec_set_lowres(AVCodecContext *, int)
        int av_dup_packet(AVPacket *)
        void av_free_packet(AVPacket *)
        void avcodec_free_frame(AVFrame **)
        void avsubtitle_free(AVSubtitle *)
        void av_fast_malloc(void *, unsigned int *, size_t)
        void avcodec_register_all()
        int avcodec_close(AVCodecContext *)
        int avcodec_decode_video2(AVCodecContext *, AVFrame *, int *, const AVPacket *)
        void avcodec_flush_buffers(AVCodecContext *)
        int av_lockmgr_register(lockmgr_func)
        void av_init_packet(AVPacket *)
        enum AVLockOp:
            AV_LOCK_CREATE,
            AV_LOCK_OBTAIN,
            AV_LOCK_RELEASE,
            AV_LOCK_DESTROY,
        void av_picture_copy(AVPicture *, const AVPicture *,
                             AVPixelFormat, int, int)
        AVFrame *avcodec_alloc_frame()
        AVFrame* av_frame_alloc()
        void avcodec_get_frame_defaults(AVFrame *)
        int avcodec_decode_subtitle2(AVCodecContext *, AVSubtitle *,
                                     int *, AVPacket *)
        int avcodec_decode_audio4(AVCodecContext *, AVFrame *, int *, const AVPacket *)
        enum AVCodecID:
            AV_CODEC_ID_RAWVIDEO
        AVCodec *avcodec_find_decoder(AVCodecID)
        AVCodec *avcodec_find_encoder(AVCodecID)
        AVCodec *avcodec_find_encoder_by_name(const char *)
        AVCodec *avcodec_find_decoder_by_name(const char *)
        const AVClass *avcodec_get_class()
        int avcodec_open2(AVCodecContext *, const AVCodec *, AVDictionary **)
        enum AVDiscard:
            AVDISCARD_DEFAULT,
            AVDISCARD_ALL
        int av_copy_packet(AVPacket *, AVPacket *)
        struct AVCodecDescriptor:
            AVCodecID id
            const char *name
            AVMediaType type
        const AVCodecDescriptor *avcodec_descriptor_get(AVCodecID)
        const AVCodecDescriptor *avcodec_descriptor_next(const AVCodecDescriptor *)
        const AVCodecDescriptor *avcodec_descriptor_get_by_name(const char *)
        AVPixelFormat avcodec_find_best_pix_fmt_of_list(AVPixelFormat *, AVPixelFormat,
                                                        int, int *)
        int avpicture_fill(AVPicture *, const uint8_t *, AVPixelFormat, int, int)
        int avcodec_encode_video2(AVCodecContext *, AVPacket *, const AVFrame *, int *)
        const char *avcodec_get_name(AVCodecID)
        AVCodec *av_codec_next(const AVCodec *)
        int av_codec_is_encoder(const AVCodec *)
        int av_codec_is_decoder(const AVCodec *)
    extern from "libavfilter/avfilter.h" nogil:
        struct AVFilterContext:
            AVFilterLink **inputs
        struct AVFilterLink:
            AVRational time_base
            int sample_rate
            int channels
            uint64_t channel_layout
            AVRational frame_rate
        struct AVFilterGraph:
            char *scale_sws_opts
        struct AVFilterInOut:
            char *name
            AVFilterContext *filter_ctx
            int pad_idx
            AVFilterInOut *next
        struct AVFilter:
            pass
        void avfilter_register_all()
        AVFilterInOut *avfilter_inout_alloc()
        void avfilter_inout_free(AVFilterInOut **)
        int avfilter_graph_parse_ptr(AVFilterGraph *, const char *,
                                     AVFilterInOut **, AVFilterInOut **,
                                     void *)
        int avfilter_link(AVFilterContext *, unsigned,
                          AVFilterContext *, unsigned)
        int avfilter_graph_config(AVFilterGraph *, void *)
        int avfilter_graph_create_filter(AVFilterContext **, const AVFilter *,
                                         const char *, const char *, void *,
                                         AVFilterGraph *)
        AVFilter *avfilter_get_by_name(const char *)
        void avfilter_graph_free(AVFilterGraph **)
        AVFilterGraph *avfilter_graph_alloc()

    extern from "libavfilter/buffersink.h" nogil:
        pass

    extern from "libavfilter/buffersrc.h" nogil:
        int av_buffersrc_add_frame(AVFilterContext *, AVFrame *)
        int av_buffersink_get_frame_flags(AVFilterContext *, AVFrame *, int)
    #endif

    extern from "libpostproc/postprocess.h" nogil:
        pass

    extern from "ffinfo.h" nogil:
        uint8_t INDENT
        uint8_t SHOW_VERSION
        uint8_t SHOW_CONFIG
        void print_all_libs_info(int, int)
        int opt_default(const char *, const char *, SwsContext *, AVDictionary **,
                        AVDictionary **, AVDictionary **)

cdef enum:
    AV_SYNC_AUDIO_MASTER, # default choice
    AV_SYNC_VIDEO_MASTER,
    AV_SYNC_EXTERNAL_CLOCK, # synchronize to an external clock
