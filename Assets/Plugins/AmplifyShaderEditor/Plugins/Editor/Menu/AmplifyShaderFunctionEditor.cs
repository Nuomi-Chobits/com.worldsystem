using UnityEngine;
using UnityEditor;
using System;
using System.Text.RegularExpressions;
using System.IO;
using System.Collections.Generic;

namespace AmplifyShaderEditor
{
	[CustomEditor( typeof( AmplifyShaderFunction ) )]
	public class AmplifyShaderFunctionEditor : Editor
	{
		class FunctionDependency
		{
			public string AssetName;
			public string AssetPath;
			public FunctionDependency(string name, string path)
			{
				AssetName = name;
				AssetPath = path;
			}
		}

		AmplifyShaderFunction m_target;
		List<FunctionDependency> m_dependencies = new List<FunctionDependency>();

		void OnEnable()
		{
			m_target = ( target as AmplifyShaderFunction );
		}

		public override void OnInspectorGUI()
		{
			
			
			if( GUILayout.Button( 
#if !WB_LANGUAGE_CHINESE
"Open in Shader Editor"
#else
"在着色器编辑器中打开"
#endif
) )
			{
				ASEPackageManagerHelper.SetupLateShaderFunction( m_target );
			}
			
			

			if( m_target.Description.Length > 0 )
			{
				EditorGUILayout.HelpBox( m_target.Description, MessageType.Info );
			}

			EditorGUILayout.Space();
			if( GUILayout.Button( 
#if !WB_LANGUAGE_CHINESE
"Search Direct Dependencies"
#else
"搜索直接依赖关系"
#endif
) )
			{
				m_dependencies.Clear();
				string guid = AssetDatabase.AssetPathToGUID( AssetDatabase.GetAssetPath( m_target ) );

				string[] allSFs = AssetDatabase.FindAssets( "t:AmplifyShaderFunction", null );
				foreach( string guid1 in allSFs )
				{
					string sfPath = AssetDatabase.GUIDToAssetPath( guid1 );
					bool found = SearchForGUID( guid, sfPath );
					if( found )
					{
						
						string n = Regex.Replace( sfPath, @"[\w\d\/]+\/", "" );
						m_dependencies.Add(new FunctionDependency( n, sfPath ) );
					}
				}

				string[] allSHs = AssetDatabase.FindAssets( "t:Shader", null );
				foreach( string guid1 in allSHs )
				{
					string shPath = AssetDatabase.GUIDToAssetPath( guid1 );
					bool found = SearchForGUID( guid, shPath );
					if( found )
					{
						string n = Regex.Replace( shPath, @"[\w\d\/]+\/", "" );
						m_dependencies.Add( new FunctionDependency( n, shPath ) );
					}
				}
			}
			EditorGUILayout.Space();
			for( int i = 0; i < m_dependencies.Count; i++ )
			{
				EditorGUILayout.BeginHorizontal();
				if( GUILayout.Button( m_dependencies[ i ].AssetName, 
#if !WB_LANGUAGE_CHINESE
"minibuttonleft"
#else
"左小按钮"
#endif
) )
				{
					SelectAtPath( m_dependencies[ i ].AssetPath );
				}
				if( GUILayout.Button( 
#if !WB_LANGUAGE_CHINESE
"edit"
#else
"编辑"
#endif
, 
#if !WB_LANGUAGE_CHINESE
"minibuttonright"
#else
"小按钮右"
#endif
, GUILayout.Width(100) ) )
				{
					if( m_dependencies[ i ].AssetName.EndsWith( ".asset" ) )
					{
						var obj = AssetDatabase.LoadAssetAtPath<AmplifyShaderFunction>( m_dependencies[ i ].AssetPath );
						AmplifyShaderEditorWindow.LoadShaderFunctionToASE( obj, false );
					} 
					else
					{
						var obj = AssetDatabase.LoadAssetAtPath<Shader>( m_dependencies[ i ].AssetPath );
						AmplifyShaderEditorWindow.ConvertShaderToASE( obj );
					}
				}
				EditorGUILayout.EndHorizontal();
			}

			if( m_dependencies.Count > 0 )
			{
				List<string> assetPaths = new List<string>();
				for( int i = 0; i < m_dependencies.Count; i++ )
				{
					assetPaths.Add( m_dependencies[ i ].AssetPath );
				}

				if( GUILayout.Button( 
#if !WB_LANGUAGE_CHINESE
"Open and Save All"
#else
"打开并保存全部"
#endif
) )
				{
					bool doit = EditorUtility.DisplayDialog( "Open and Save All", "This will try to open all shader function and shaders that use this shader function and save them in quick succession, this may irreversibly break your files if something goes wrong. Are you sure you want to try?", "Yes, I'll take the risk", "No, I'll do it myself" );
					if( doit )
						AmplifyShaderEditorWindow.LoadAndSaveList( assetPaths.ToArray() );
				}
			}
		}

		public void SelectAtPath( string path )
		{
			var obj = AssetDatabase.LoadAssetAtPath<UnityEngine.Object>( path );
			EditorGUIUtility.PingObject( obj );
		}

		public static bool SearchForGUID( string guid, string pathName )
		{
			bool result = false;
			int count = 0;
			if( !string.IsNullOrEmpty( pathName ) && File.Exists( pathName ) )
			{
				StreamReader fileReader = null;
				try
				{
					fileReader = new StreamReader( pathName );

					string line;
					int index = -1;
					while( ( line = fileReader.ReadLine() ) != null )
					{
						index = line.IndexOf( guid );
						count++;

						if( index > -1 )
						{
							result = true;
							break;
						}
					}
				}
				catch( Exception e )
				{
					Debug.LogException( e );
				}
				finally
				{
					if( fileReader != null )
						fileReader.Close();
				}
			}
			return result;
		}
	}
}
