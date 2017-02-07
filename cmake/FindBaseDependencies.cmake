function(FindGlib libs)
  pkg_check_modules(GLIB-2.0    REQUIRED glib-2.0)
  pkg_check_modules(GOBJECT-2.0 REQUIRED gobject-2.0)
  pkg_check_modules(GIO-2.0     REQUIRED gio-2.0)

  set(GLIB_LIBS "")
  if(GLIB-2.0_FOUND)
    list(APPEND GST_LIBS ${GLIB-2.0_LIBRARIES})
    include_directories (${GLIB-2.0_INCLUDE_DIRS})
  endif()

  if(GOBJECT-2.0_FOUND)
    list(APPEND GST_LIBS ${GOBJECT-2.0_LIBRARIES})
    include_directories (${GOBJECT-2.0_INCLUDE_DIRS})
  endif()

  if(GIO-2.0_FOUND)
    list(APPEND GST_LIBS ${GIO-2.0_LIBRARIES})
    include_directories (${GIO-2.0_INCLUDE_DIRS})
  endif()
  set(${libs} ${GLIB_LIBS} PARENT_SCOPE)
endfunction(FindGlib)

function(FindGstreamer libs)
  pkg_check_modules (GSTREAMER            REQUIRED gstreamer-1.0>=1.6)
  pkg_check_modules (GSTREAMER_VIDEO      REQUIRED gstreamer-video-1.0>=1.6)
  pkg_check_modules (GSTREAMER_ALLOCATORS REQUIRED gstreamer-allocators-1.0>=1.6)
  pkg_check_modules (GSTREAMER_GL	  gstreamer-gl-1.0)
  set(GST_LIBS "")
  if(GSTREAMER_FOUND)
    list(APPEND GST_LIBS ${GSTREAMER_LIBRARIES})
    include_directories (${GSTREAMER_INCLUDE_DIRS})
  endif()

  if(GSTREAMER_VIDEO_FOUND)
    list(APPEND GST_LIBS ${GSTREAMER_VIDEO_LIBRARIES})
    include_directories (${GSTREAMER_VIDEO_INCLUDE_DIRS})
  endif()

  if(GSTREAMER_ALLOCATORS_FOUND)
    list(APPEND GST_LIBS ${GSTREAMER_ALLOCATORS_LIBRARIES})
    include_directories (${GSTREAMER_ALLOCATORS_INCLUDE_DIRS})
  endif()

  if(GSTREAMER_GL_FOUND)
    list(APPEND GST_LIBS ${GSTREAMER_GL_LIBRARIES})
    include_directories (${GSTREAMER_GL_INCLUDE_DIRS})
    add_definitions(-DHAVE_GST_GL_LIBS)
  endif()
  set(${libs} ${GST_LIBS} PARENT_SCOPE)
endfunction(FindGstreamer)

function(FindVideoDriver libs)
  pkg_check_modules(LIBVA        REQUIRED libva)
  pkg_check_modules(LIBDRM       REQUIRED libdrm)
  pkg_check_modules(LIBDRM_INTEL REQUIRED libdrm_intel)
  pkg_check_modules(LIBVA_DRM    REQUIRED libva-drm)
  pkg_check_modules(LIBUDEV      REQUIRED libudev)
  
  set(VIDEO_DRIVER "")
  if(LIBVA_FOUND)
    list(APPEND VIDEO_DRIVER ${LIBVA_LIBRARIES})
    include_directories (${LIBVA_INCLUDE_DIRS})
  endif()

  if(LIBDRM_FOUND)
    list(APPEND VIDEO_DRIVER ${LIBDRM_LIBRARIES})
    include_directories (${LIBDRM_INCLUDE_DIRS})
  endif()

  if(LIBDRM_INTEL_FOUND)
    list(APPEND VIDEO_DRIVER ${LIBDRM_INTEL_LIBRARIES})
    include_directories (${LIBDRM_INTEL_INCLUDE_DIRS})
  endif()

  if(LIBVA_DRM_FOUND)
    list(APPEND VIDEO_DRIVER ${LIBVA_DRM_LIBRARIES})
    include_directories (${LIBVA_DRM_INCLUDE_DIRS})
  endif()

  if(LIBUDEV_FOUND)
    list(APPEND VIDEO_DRIVER ${LIBUDEV_LIBRARIES})
    include_directories (${LIBUDEV_INCLUDE_DIRS})
  endif()
  set(${libs} ${VIDEO_DRIVER} PARENT_SCOPE)
endfunction(FindVideoDriver)

function(FindBaseLibs libs)
  set(glib_libs "")
  set(gst_libs  "")
  set(drv_libs  "")
  FindGlib(glib_libs)
  FindGstreamer(gst_libs)
  FindVideoDriver(drv_libs)
  set(${libs} ${${libs}} ${glib_libs} ${gst_libs} ${drv_libs} PARENT_SCOPE)
endfunction(FindBaseLibs)
