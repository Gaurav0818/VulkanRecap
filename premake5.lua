workspace "VulkanRecap"
	architecture "x64"
	startproject "Core"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDir ={}
IncludeDir["GLFW"] = "External/glfw/include"

include "External/glfw"

project "Core"
	location "Core"
	kind "ConsoleApp"
	language "C++"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("obj/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{IncludeDir.GLFW}"
	}

	links
	{
		"GLFW",
		"opengl32"
	}

	filter "system:windows"
		cppdialect "C++20"
		staticruntime "off"
		systemversion "latest"

	filter "configurations:Debug"
		defines "LQD_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "LQD_RELEASE"
		symbols "On"

	filter "configurations:Dist"
		defines "LQD_DIST"
		symbols "On"