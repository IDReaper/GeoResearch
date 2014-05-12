/////////////////////////
// Copyright 2007 Google Inc. All Rights Reserved.
/////////////////////////
#include <atmosphere_common.ini>

/////////////////////////
//	INTERFACE
//
// Used in the modeling tool for this shader.
/////////////////////////
[INTERFACE]
section=atmosphere_ground_sun_on

[atmosphere_ground_sun_on]
attrs=


/////////////////////////
//	CONFIGURATION
//
//	This section links this shader with an external
// configuration (.cfg) file.  It als sets the
//	default implementation.
/////////////////////////
[CONFIGURATION]
//	The configuration file used to customize
//	this shader for different platforms.
fileName=atmosphere_ground_sun_on.cfg

//	The default implementation that will be used if
//	one is not specified in the configuration file.
//	This implementation can be overridden in textured.cfg
implementation=hardware_shader_implementation


/////////////////////////
//	IMPLEMENTATION
//
//	This section defines each of the implementations
// of this shader.  Each implementation must
//	declare the passes that it will be using, its
// shader processor, and whether or not to use a
//	render package for the shader.
/////////////////////////
[hardware_shader_implementation]
passes=single_pass
//	Use the default processor.
processor=defaultProcessor
//	Single-pass shaders do not need to use
//	render packages.
useRenderPackage = false

/////////////////////////
//	PASS DECLARATIONS
//
//	This section defines that attributes that will be pushed during
//	each pass of the shader.  The [CONFIGURATION] section defines
//	which of these passes will be used by the shader.
/////////////////////////
[single_pass]
attrs=enableVertexShader,bindVertexShader,enablePixelShader,bindPixelShader

/////////////////////////
// PROCESSORS
//
//	Below are the definitions of each of the shader processors
//	used by this shader.
/////////////////////////
[defaultProcessor]
//	This shader does not use a custom processor, so
//	just use igShaderProcessor.  igShaderProcessor can
//	be replaced with any class derived from
//	igShaderProcessor.
type=igShaderProcessor

/////////////////////////
//	ATTRIBUTES
//
//	Below are definitions of all the attributes used by the shader.
/////////////////////////

/////////////////////////
// Vertex Shader
/////////////////////////
[enableVertexShader]
type=igVertexPipelineModeAttr
fields=_mode
_mode.value=IG_GFX_VERTEX_PIPELINE_MODE_SHADER
const = false

[bindVertexShader]
type=igVertexShaderBindAttr
fields=_vertexShader
// object values can refer to another section.
_vertexShader.value=vertexShader
const = false

[vertexShader]
type=igVertexShaderAttr
fields=_textDefinition,_entryPoint,_stateList
// File containing shader program. Default to ARB version.
_textDefinition.file=atmosphere_ground_sun_on.arbvp1
_entryPoint.value=vmain
_stateList.value = modelView_VS, modelViewProj_VS, worldOriginInView_VS,\
  textureMatrix_VS,cameraToSunDirAndExposure_VS, lightDirectionInModel_VS,\
  atmosphereCustomState_VS, cameraLightInfo_VS, startupConsts_VS,\
  sunsetAmbientAndFogDensity_VS, blendMorphVertexParams_VS
const = false

/////////////////////////
// Pixel Shader
/////////////////////////
[enablePixelShader]
type=igPixelPipelineModeAttr
fields=_pipelineMode
_pipelineMode.value=IG_GFX_PIXEL_PIPELINE_MODE_SHADER
const = false

[bindPixelShader]
type=igPixelShaderBindAttr
fields=_pixelShader
// object values can refer to another section.
_pixelShader.value=pixelShader
const = false

[pixelShader]
type=igPixelShaderAttr
fields=_textDefinition,_entryPoint,_samplerList,_stateList
// File containing shader program. Default to ARB version.
_textDefinition.file=atmosphere_ground_sun_on.arbfp1
_entryPoint.value=pmain
_samplerList.value = groundTexture_PS, blendTexture_PS
_stateList.value = atmosphereCustomState_PS, atmosphereCustomColor_PS,\
  fogColor_PS, blendUnpopPixelParams_PS
const = false
