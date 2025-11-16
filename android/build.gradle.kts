import java.io.File
import org.gradle.api.tasks.Delete

// Repositórios de todos os projetos
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Define o diretório de build principal fora do rootProject
val newBuildDir: File = rootProject.projectDir.resolve("../../Meu Projeto/build")
rootProject.buildDir = newBuildDir

// Configura o diretório de build para cada subprojeto
subprojects {
    project.buildDir = newBuildDir.resolve(project.name)
    // Se houver dependência de avaliação com outro módulo
    project.evaluationDependsOn(":app")
}

// Task clean
tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
    subprojects.forEach { delete(it.buildDir) }
}
