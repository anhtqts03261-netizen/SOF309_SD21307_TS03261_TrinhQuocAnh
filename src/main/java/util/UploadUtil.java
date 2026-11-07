package util;

import java.io.File;

import jakarta.servlet.ServletContext;

public class UploadUtil {

    public static String getUploadPath(ServletContext context, String folder) {

        try {

            // Thư mục deploy của Tomcat
            File deployFolder =
                    new File(context.getRealPath("/"));

            // Đi lên tới workspace
            File current = deployFolder;

            while (current != null &&
                    !current.getName().equals(".metadata")) {

                current = current.getParentFile();
            }

            if (current == null) {

                throw new RuntimeException("Không tìm thấy Eclipse Workspace");

            }

            File workspace = current.getParentFile();

            String projectName =
                    context.getContextPath().replace("/", "");

            File project =
                    new File(workspace, projectName);

            File uploadFolder =
                    new File(project,
                            "src/main/webapp/assets/images/" + folder);

            if (!uploadFolder.exists()) {

                uploadFolder.mkdirs();

            }

            return uploadFolder.getAbsolutePath();

        }

        catch (Exception e) {

            e.printStackTrace();

            return new File(
                    context.getRealPath("/assets/images/" + folder))
                    .getAbsolutePath();

        }

    }

}