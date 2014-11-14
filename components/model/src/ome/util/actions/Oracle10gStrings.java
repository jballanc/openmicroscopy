package ome.util.actions;

import java.util.MissingResourceException;
import java.util.ResourceBundle;

import ome.util.SqlAction;

public class Oracle10gStrings {

    private static final String BUNDLE_NAME_DEFAULT = "ome.util.actions.default"; //$NON-NLS-1$

    private static final String BUNDLE_NAME = "ome.util.actions.oracle10g"; //$NON-NLS-1$

    private static final ResourceBundle RESOURCE_BUNDLE_DEFAULT = ResourceBundle
            .getBundle(BUNDLE_NAME_DEFAULT);

    private static final ResourceBundle RESOURCE_BUNDLE = ResourceBundle
            .getBundle(BUNDLE_NAME);

    private Oracle10gStrings() {
    }

    public static String getString(String key) {
        try {
            return RESOURCE_BUNDLE.getString(key);
        } catch (MissingResourceException e) {
            try {
                return RESOURCE_BUNDLE_DEFAULT.getString(key);
            } catch (MissingResourceException e2) {
                throw new ome.conditions.InternalException("Unknown property: "
                    + key);
            }
        }
    }
}
